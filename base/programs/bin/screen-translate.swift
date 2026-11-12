// Helper of screen-translate (compiled by it to ~/Library/Caches/screen-translate/): OCR an image with Vision
// (Japanese + English), translate it on-device with Apple's Translation framework and copy it / show it in a panel.
// Usage: screen-translate-helper copy|show|text IMAGE
import AppKit
import Translation
import Vision

// MARK: OCR

struct Line { let text: String; let box: CGRect } // box: normalized, origin bottom-left

func recognize(_ url: URL) throws -> [Line] {
  let req = VNRecognizeTextRequest()
  req.recognitionLevel = .accurate
  req.recognitionLanguages = ["ja-JP", "en-US"]
  req.usesLanguageCorrection = true
  try VNImageRequestHandler(url: url).perform([req])
  return (req.results ?? []).compactMap { o in
    o.topCandidates(1).first.map { Line(text: $0.string, box: o.boundingBox) }
  }.sorted { abs($0.box.midY - $1.box.midY) > min($0.box.height, $1.box.height) / 2
    ? $0.box.midY > $1.box.midY : $0.box.minX < $1.box.minX }
}

func isCJK(_ c: Character) -> Bool {
  c.unicodeScalars.contains { s in
    (0x3040...0x30FF).contains(s.value) || (0x3400...0x9FFF).contains(s.value) || (0xFF00...0xFFEF).contains(s.value)
      || (0x3000...0x303F).contains(s.value)
  }
}

// Joins lines wrapped inside a paragraph (slides break sentences mid-way, which ruins the translation); a new
// paragraph starts after a vertical gap, sentence-final punctuation, a short (title-like) line, an outdent or a bullet.
func paragraphs(_ lines: [Line]) -> [String] {
  var paras: [String] = []
  var prev: Line?
  let bullet = try! NSRegularExpression(pattern: #"^\s*([・•●○■□◆◇▶►※\-–—*]|\(?[0-9０-９]+[.)．）]|[①-⑳])"#)
  for l in lines {
    let t = l.text.trimmingCharacters(in: .whitespaces)
    guard !t.isEmpty else { continue }
    if let p = prev, var last = paras.last {
      let h = max(p.box.height, l.box.height)
      let gap = p.box.minY - l.box.maxY
      let ended = last.last.map { "。．！？!?:：」』)）".contains($0) } ?? true
      let short = p.box.width < 0.6 * max(l.box.width, p.box.width) && p.box.maxX < l.box.maxX - 2 * h
      let outdent = l.box.minX < p.box.minX - h
      let farIndent = l.box.minX > p.box.minX + 4 * h
      let isBullet = bullet.firstMatch(in: t, range: NSRange(t.startIndex..., in: t)) != nil
      if gap < 0.8 * h && gap > -0.5 * h && !ended && !short && !outdent && !farIndent && !isBullet {
        let cjkJoin = last.last.map(isCJK) == true && t.first.map(isCJK) == true
        last += (cjkJoin ? "" : " ") + t
        paras[paras.count - 1] = last
        prev = l
        continue
      }
    }
    paras.append(t)
    prev = l
  }
  return paras
}

// MARK: translation

func isJapanese(_ s: String) -> Bool {
  let kana = s.unicodeScalars.filter { (0x3040...0x30FF).contains($0.value) }.count
  let han = s.unicodeScalars.filter { (0x3400...0x9FFF).contains($0.value) }.count
  let letters = s.unicodeScalars.filter { CharacterSet.letters.contains($0) }.count
  return letters > 0 && Double(kana + han) / Double(letters) > 0.2
}

func translate(_ paras: [String], from src: String, to dst: String) async throws -> [String] {
  let s = TranslationSession(installedSource: Locale.Language(identifier: src), target: Locale.Language(identifier: dst))
  let rs = try await s.translations(from: paras.enumerated().map {
    TranslationSession.Request(sourceText: $0.element, clientIdentifier: String($0.offset))
  })
  let byId = Dictionary(rs.map { ($0.clientIdentifier ?? "", $0.targetText) }, uniquingKeysWith: { a, _ in a })
  return paras.indices.map { byId[String($0)] ?? "" }
}

// MARK: output

func setClipboard(_ s: String) {
  NSPasteboard.general.clearContents()
  NSPasteboard.general.setString(s, forType: .string)
}

func notify(_ title: String, _ body: String) {
  let esc = { (s: String) in s.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\"") }
  let p = Process()
  p.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
  p.arguments = ["-e", "display notification \"\(esc(String(body.prefix(240))))\" with title \"\(esc(title))\""]
  try? p.run()
  p.waitUntilExit()
}

final class Panel: NSPanel {
  override var canBecomeKey: Bool { true }
}

final class Shower: NSObject, NSWindowDelegate {
  let panel: Panel
  let text: NSTextView
  let translation: String

  init(translation: String, original: String) {
    self.translation = translation
    let width: CGFloat = 460
    let a = NSMutableAttributedString(string: translation, attributes: [
      .font: NSFont.systemFont(ofSize: 13), .foregroundColor: NSColor.labelColor,
    ])
    a.append(NSAttributedString(string: "\n\n" + original, attributes: [
      .font: NSFont.systemFont(ofSize: 11), .foregroundColor: NSColor.secondaryLabelColor,
    ]))
    let mouse = NSEvent.mouseLocation
    let screen = NSScreen.screens.first { NSMouseInRect(mouse, $0.frame, false) } ?? NSScreen.main!
    let vis = screen.visibleFrame

    text = NSTextView(frame: NSRect(x: 0, y: 0, width: width, height: 10))
    text.isEditable = false
    text.isSelectable = true
    text.drawsBackground = false
    text.textContainerInset = NSSize(width: 10, height: 8)
    text.textStorage?.setAttributedString(a)
    text.layoutManager?.ensureLayout(for: text.textContainer!)
    let used = text.layoutManager?.usedRect(for: text.textContainer!).height ?? 100
    let height = min(used + 20, vis.height * 0.6)

    let scroll = NSScrollView(frame: NSRect(x: 0, y: 0, width: width, height: height))
    scroll.documentView = text
    scroll.hasVerticalScroller = used + 20 > height
    scroll.drawsBackground = false
    text.autoresizingMask = [.width]

    panel = Panel(contentRect: NSRect(x: 0, y: 0, width: width, height: height),
                  styleMask: [.titled, .closable, .utilityWindow, .hudWindow, .nonactivatingPanel],
                  backing: .buffered, defer: false)
    super.init()
    panel.title = "screen-translate"
    panel.contentView = scroll
    panel.level = .statusBar // above full-screen presentations and meeting windows
    panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    panel.hidesOnDeactivate = false
    panel.isMovableByWindowBackground = true
    panel.delegate = self
    // next to the mouse, which screencapture leaves at a corner of the selection
    var f = panel.frame
    f.origin = NSPoint(x: mouse.x + 12, y: mouse.y - f.height - 12)
    f.origin.x = min(max(f.origin.x, vis.minX), vis.maxX - f.width)
    f.origin.y = min(max(f.origin.y, vis.minY), vis.maxY - f.height)
    panel.setFrame(f, display: true)
  }

  func show() {
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] e in
      guard let self else { return e }
      let cmd = e.modifierFlags.contains(.command)
      switch (e.keyCode, cmd, e.charactersIgnoringModifiers) {
      case (53, _, _), (_, true, "w"), (_, true, "q"): NSApp.terminate(nil)
      case (_, true, "c"):
        let r = self.text.selectedRange()
        setClipboard(r.length > 0 ? (self.text.string as NSString).substring(with: r) : self.translation)
      case (_, true, "a"): self.text.selectAll(nil)
      default: return e
      }
      return nil
    }
    panel.makeKeyAndOrderFront(nil)
  }

  func windowWillClose(_ notification: Notification) { NSApp.terminate(nil) }
}

// MARK: main

@main struct Main {
  // Translation needs the main run loop, so everything runs as a main-actor task inside NSApp.run()
  static func main() {
    let args = CommandLine.arguments
    guard args.count == 3, ["copy", "show", "text"].contains(args[1]) else {
      FileHandle.standardError.write("usage: screen-translate-helper copy|show|text IMAGE\n".data(using: .utf8)!)
      exit(2)
    }
    let app = NSApplication.shared
    app.setActivationPolicy(.accessory)
    Task { @MainActor in
      do {
        if let s = try await run(mode: args[1], image: URL(fileURLWithPath: args[2])) {
          objc_setAssociatedObject(app, "shower", s, .OBJC_ASSOCIATION_RETAIN)
        } else {
          exit(0)
        }
      } catch {
        notify("screen-translate failed", "\(error.localizedDescription) (Japanese translation language downloaded? System Settings > General > Language & Region > Translation Languages)")
        FileHandle.standardError.write("screen-translate: \(error)\n".data(using: .utf8)!)
        exit(1)
      }
    }
    app.run()
  }

  // returns the panel in show mode (kept alive until it is closed), nil when done
  @MainActor static func run(mode: String, image: URL) async throws -> Shower? {
    let paras = paragraphs(try recognize(image))
    guard !paras.isEmpty else { notify("screen-translate", "No text found"); return nil }
    let original = paras.joined(separator: "\n")
    if mode == "text" {
      setClipboard(original)
      notify("Copied text", original)
      print(original)
      return nil
    }
    let ja = isJapanese(original)
    // bullet marks get lost in translation: translate without them and put "• " back
    let mark = try! NSRegularExpression(pattern: #"^[・•●○■□◆◇▶►]\s*"#)
    let bulleted = paras.map { mark.firstMatch(in: $0, range: NSRange($0.startIndex..., in: $0)) }
    let bare = zip(paras, bulleted).map { p, m in m.map { (p as NSString).substring(from: $0.range.upperBound) } ?? p }
    let translated = try await translate(bare, from: ja ? "ja" : "en", to: ja ? "en" : "ja")
    let out = zip(translated, bulleted).map { t, m in (m == nil ? "" : "• ") + t }.joined(separator: "\n")
    setClipboard(out)
    print(out)
    fflush(stdout)
    if mode == "copy" {
      notify("Copied translation", out)
      return nil
    }
    let s = Shower(translation: out, original: original)
    s.show()
    if ProcessInfo.processInfo.environment["SCREEN_TRANSLATE_DEBUG"] != nil { // invisible self-check
      s.panel.alphaValue = 0
      try await Task.sleep(for: .seconds(1))
      let wins = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? [[String: Any]] ?? []
      let mine = wins.filter { $0[kCGWindowOwnerPID as String] as? Int32 == getpid() }
      print("frame \(s.panel.frame) visible \(s.panel.isVisible) key \(s.panel.isKeyWindow) onscreen \(mine)")
      exit(0)
    }
    return s
  }
}
