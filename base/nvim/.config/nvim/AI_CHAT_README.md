# AI Chat Configuration for Neovim

This configuration includes two AI assistants you can chat with inside Neovim.

## CopilotChat (GitHub Copilot)

### Setup
1. Make sure you have GitHub Copilot enabled (requires subscription)
2. Already configured with copilot.lua plugin

### Keybindings
- `<leader>aa` - Toggle Copilot Chat window
- `<leader>ae` - Explain selected code
- `<leader>ar` - Review selected code
- `<leader>af` - Fix selected code
- `<leader>ao` - Optimize selected code
- `<leader>ad` - Generate documentation
- `<leader>at` - Generate tests
- `<leader>ac` - Write commit message

### Usage
1. Open the chat: `<leader>aa`
2. Type your question and press `<CR>` to send
3. Use `q` to close the window
4. Use `<C-r>` to reset the conversation

---

## Gemini (Google Gemini)

### Setup
1. Get your API key from: https://aistudio.google.com/app/apikey
2. Add to your shell config (~/.zshrc or ~/.bashrc):
   ```bash
   export GEMINI_API_KEY="your-api-key-here"
   ```
3. Restart your terminal or run: `source ~/.zshrc`
4. Install Python dependency: `pip install -U google-generativeai`

### Keybindings
- `<leader>ag` - Toggle Gemini Chat window
- `<leader>ag` (visual mode) - Chat with selected code as context
- `<leader>aG` - Toggle Gemini Code window (specialized for code generation)
- `<leader>aG` (visual mode) - Generate code based on selected context

### Usage
1. Open the chat: `<leader>ag`
2. Type your question and chat naturally
3. For code generation, use `<leader>aG`

---

## Which One to Use?

**CopilotChat (GitHub Copilot):**
- Better integration with GitHub ecosystem
- Faster responses
- Requires GitHub Copilot subscription (~$10/month)
- Great for code review and quick fixes

**Gemini:**
- Free API tier available
- More conversational
- Better for complex reasoning
- Larger context window (up to 2M tokens with Gemini 1.5)

---

## Tips
- Use visual selection before invoking to provide context
- Both can read your current buffer content
- Great for explaining complex code, debugging, or learning new concepts
- Can generate boilerplate code, tests, and documentation
