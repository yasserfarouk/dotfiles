# Keymap Conflicts & Recommendations

**Generated:** 2025-10-28  
**Total Keymaps:** 306  
**Conflicts Found:** 18 (8 critical, 10 minor)

---

## 🔴 CRITICAL CONFLICTS (Need Immediate Fix)

### 1. `<leader>e` - File Explorer Conflict
**Problem:** Two different file explorers bound to the same key

**Current:**
- `<leader>e` → Snacks dashboard (snacks.lua:127)
- `<leader>e` → NvimTree explorer (nvimtree.lua:115) 

**Recommendation:**
```lua
# Keep snacks for <leader>e (file explorer on current file)
# Change NvimTree to <leader>E (uppercase) or remove if using snacks
```

**Action:** Choose ONE file explorer and stick with it. Snacks seems newer and more maintained.

---

### 2. `<leader>E` - Explorer Root Conflict
**Problem:** Both bound to explorer operations

**Current:**
- `<leader>E` → Snacks explorer (snacks.lua:128)  
- `<leader>E` → NvimTree explorer on root (nvimtree.lua:114)

**Recommendation:**
```lua
# If keeping both explorers:
<leader>e  → Snacks explorer on current file
<leader>E  → Snacks explorer on root
<leader>fe → NvimTree toggle (under "f" for files)

# If using only one:
Remove the unused plugin entirely
```

---

### 3. `<F5>` - Tex vs Debug Conflict
**Problem:** LaTeX compile vs Debug navigation

**Current:**
- `<F5>` → VimtexCompileSelected (tex.lua:8)
- `<F5>` → DebugUp (debug.lua:65)

**Recommendation:**
```lua
<F6>  → VimtexCompileSelected (LaTeX compile)
<F5>  → DebugUp (move debug navigation to F6-F8 range)
```

---

### 4. `<F9>` - Tex Stop vs Debug Step Over
**Problem:** Both critical operations

**Current:**
- `<F9>` → VimtexStop (tex.lua:7)
- `<F9>` → DebugStepOver (debug.lua:74)

**Recommendation:**
```lua
# Standard debug shortcuts use F9 for breakpoints, F10 for step over
# Move VimTeX stop to different key
<F6>  → VimtexCompile
<F8>  → VimtexStop (less used, different key)
<F9>  → Toggle breakpoint (standard)
<F10> → Debug step over (standard)
```

---

### 5. `<leader>af` - Copilot Fix vs Format Enable
**Problem:** AI fix code vs enable autoformat

**Current:**
- `<leader>af` → Copilot Fix Code (copilot.lua:124)
- `<leader>af` → Enable autoformat (conform.lua:46)

**Recommendation:**
```lua
# AI operations under <leader>a (ai)
<leader>af → Copilot Fix Code (keep)
<leader>aF → Enable autoformat (uppercase F)

# OR group format under <leader>f (format)
<leader>ff → Format buffer
<leader>fF → Enable autoformat
<leader>fv → Disable autoformat (already using aV)
```

---

### 6. `<leader>xt` - Terminal Conflict
**Problem:** Two different terminal commands

**Current:**
- `<leader>xt` → FloatermPrev (terminal.lua:9) 
- `<leader>xt` → FloatermToggle jupyter (terminal.lua:20)

**Recommendation:**
```lua
<leader>xt → Toggle main terminal (keep this)
<leader>xp → FloatermPrev (p for previous)
<leader>xj → Jupyter terminal (j for jupyter)
```

---

### 7. `<leader>;` - Telescope vs FzfLua
**Problem:** File browser vs git history

**Current:**
- `<leader>;` → Telescope file_browser (search.lua:26)
- `<leader>;` → FzfLua git_bcommits (search.lua:181)

**Recommendation:**
```lua
# You have BOTH Telescope (s) and FzfLua (S) prefixes
# Keep them separate and consistent
<leader>; → Keep as file browser (Telescope)
<leader>Sh → FzfLua git history (already exists)
```

---

### 8. `<leader>ii` - Duplicate Quickfix
**Problem:** Same command bound twice

**Current:**
- Both point to `Trouble quickfix` (init.lua:107-108)

**Recommendation:**
```lua
# Remove one, probably line 108
# Keep only one binding:
<leader>ii → LSP Info
<leader>iq → Quickfix (already have this)
```

---

## 🟡 MINOR CONFLICTS (Less Urgent)

### 9. `<leader>SC` & `<leader>Sd` - FzfLua duplicates
These seem to be copy-paste errors in search.lua where descriptions don't match commands.

**Recommendation:**
Review search.lua lines 39, 183, 196, 202 and fix descriptions to match actual commands.

---

### 10. Comment Keys in Visual Mode
`gc` and `gb` have duplicate definitions in core.lua (lines 37-41).

**Recommendation:**
Remove duplicate key definitions - nvim-comment likely auto-generates these.

---

### 11. Debug Plugin Internal Conflicts
Multiple internal conflicts in debug.lua - these are likely within plugin configurations.

**Recommendation:**
Review debug.lua structure - may be defining keys multiple times in different contexts.

---

## 📋 RECOMMENDED KEYMAP ORGANIZATION

### File Operations
```lua
<leader>e  → Explorer (current file directory)
<leader>E  → Explorer (project root)
<leader>f  → Find files (telescope/fzf)
<leader>cf → Format current buffer
<leader>cF → Enable format on save
<leader>cv → Disable format on save
```

### AI/Copilot (under `<leader>a`)
```lua
<leader>aa → Toggle Copilot Chat
<leader>ac → Commit message
<leader>ad → Generate docs
<leader>ae → Explain code
<leader>af → Fix code
<leader>ag → Gemini chat
<leader>ao → Optimize code
<leader>ar → Review code
<leader>at → Generate tests
```

### Search (under `<leader>s` for Telescope, `<leader>S` for FzfLua)
Keep this consistent - don't mix Telescope and FzfLua under same prefix.

### Terminal (under `<leader>x`)
```lua
<leader>xx → Toggle terminal
<leader>xt → Terminal (main)
<leader>xp → Previous terminal
<leader>xn → Next terminal
<leader>xg → Lazygit
<leader>xh → Htop
<leader>xj → Jupyter
```

### Function Keys
```lua
<F6>  → Compile/Run (LaTeX, code, etc)
<F7>  → Debug: Up stack frame
<F8>  → Debug: Down stack frame
<F12>  → Stop (compile, debug)
<F9>  → Debug: Toggle breakpoint
<F10> → Debug: Step over
<F11> → Debug: Step into
<S-F11> → Debug: Step out
```

---

## 🛠️ IMPLEMENTATION STEPS

1. **Backup your config** (already in git, good!)

2. **Fix critical conflicts first:**
   - Decide on ONE file explorer (Snacks or NvimTree)
   - Fix Function key conflicts (F5, F9)
   - Resolve <leader>af (AI fix vs format)
   - Clean up <leader>xt terminal keys

3. **Review and fix minor conflicts:**
   - Remove duplicate keys in core.lua
   - Fix search.lua description mismatches
   - Clean up <leader>ii duplicate

4. **Test each change:**
   - After fixing each conflict, reload Neovim
   - Test that both old and new keys work as expected
   - Update any muscle memory

5. **Document your choices:**
   - Update your personal documentation
   - Add comments in config files explaining key choices

---

## 📝 FILES TO MODIFY

Based on conflicts found, you'll need to edit:

1. **lua/plugins/snacks.lua** - File explorer keys
2. **lua/plugins/nvimtree.lua** - File explorer keys (or remove)
3. **lua/plugins/tex.lua** - Function key mappings
4. **lua/plugins/debug.lua** - Function key mappings
5. **lua/plugins/copilot.lua** - <leader>af conflict
6. **lua/plugins/conform.lua** - <leader>af conflict
7. **lua/plugins/terminal.lua** - <leader>xt conflict
8. **lua/plugins/search.lua** - <leader>; and description fixes
9. **lua/plugins/core.lua** - Remove duplicate comment keys
10. **lua/plugins/lsp/init.lua** - <leader>ii duplicate

---

## ✅ VERIFICATION

After making changes, verify with:
```vim
:Telescope keymaps
:checkhealth
```

Look for any warnings about conflicting keymaps.

---

**Next Steps:**
1. Review these recommendations
2. Modify this file with your preferences
3. Let me know when ready to apply changes
