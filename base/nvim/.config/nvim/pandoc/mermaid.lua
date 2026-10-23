-- Pandoc Lua filter: render ```mermaid blocks with the system mmdc (mermaid-cli)
-- and embed the result as a PNG. Replaces the unmaintained npm `mermaid-filter`,
-- which pins an old mermaid-cli and breaks on mermaid-cli >= 12.
local cache = (os.getenv("TMPDIR") or "/tmp") .. "/pandoc-mermaid"

function CodeBlock(block)
  if not block.classes:includes("mermaid") then
    return nil
  end
  os.execute("mkdir -p '" .. cache .. "'")
  local hash = pandoc.sha1(block.text)
  local src = cache .. "/" .. hash .. ".mmd"
  local out = cache .. "/" .. hash .. ".png"

  local existing = io.open(out, "r")
  if existing then
    existing:close()
  else
    local f = assert(io.open(src, "w"))
    f:write(block.text)
    f:close()
    local ok, err = pcall(pandoc.pipe, "mmdc",
      { "-q", "-i", src, "-o", out, "-b", "white", "-s", "3" }, "")
    if not ok then
      error("mermaid.lua: mmdc failed: " .. tostring(err))
    end
  end

  local caption = block.attributes["caption"] or ""
  local img = pandoc.Image(caption, out, "", pandoc.Attr("", {}, { width = "100%" }))
  return pandoc.Para({ img })
end
