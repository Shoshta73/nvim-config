local nnoremap = require("user.keymap_utils").nnoremap
local vnoremap = require("user.keymap_utils").vnoremap
local inoremap = require("user.keymap_utils").inoremap
local tnoremap = require("user.keymap_utils").tnoremap
local xnoremap = require("user.keymap_utils").xnoremap
local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
local conform = require("conform")
local utils = require("user.utils")

local M = {}

-- Normal --
-- Disable Space bar since it'll be used as the leader key
-- nnoremap("<space>", "<nop>")
nnoremap("<leader>t", function()
    vim.cmd("split")
    vim.cmd("terminal")
end)

nnoremap("<leader>tz", ":ZenMode<CR>")

vim.keymap.set("n", "<leader>tt", function() require("trouble").toggle() end)

nnoremap("<leader>nt", ":tabnew<CR>")
nnoremap("<leader>tn", ":tabnext<CR>")
nnoremap("<leader>tp", ":tabprevious<CR>")

-- Window +  better kitty navigation
-- nnoremap("<C-j>", function()
--     vim.cmd.wincmd("j")
-- end)
--
-- nnoremap("<C-k>", function()
--     vim.cmd.wincmd("k")
-- end)
--
-- nnoremap("<C-l>", function()
--     vim.cmd.wincmd("l")
-- end)
--
-- nnoremap("<C-h>", function()
--     vim.cmd.wincmd("h")
-- end)

-- Swap between last two buffers
nnoremap("<leader>'", "<C-^>", { desc = "Switch to last buffer" })

-- Save with leader key
nnoremap("<leader>w", "<cmd>w<cr>", { silent = false })
nnoremap("<leader>a", "<cmd>wa<cr>", { silent = false })

-- Quit with leader key
nnoremap("<leader>q", "<cmd>q<cr>", { silent = false })

-- Save and Quit with leader key
nnoremap("<leader>z", "<cmd>wq<cr>", { silent = false })

-- Map Oil to <leader>e
nnoremap("<leader>e", function()
    require("oil").toggle_float()
end)

-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
nnoremap("L", "$")
nnoremap("H", "^")

-- Press 'U' for redo
nnoremap("U", "<C-r>")

-- Turn off highlighted results
nnoremap("<leader>no", "<cmd>noh<cr>")
vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>")
-- Diagnostics

-- Goto next diagnostic of any severity
nnoremap("]d", function()
    vim.diagnostic.goto_next({})
    vim.api.nvim_feedkeys("zz", "n", false)
end)

nnoremap("<leader>dn", function()
    vim.diagnostic.goto_next({})
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous diagnostic of any severity
nnoremap("[d", function()
    vim.diagnostic.goto_prev({})
    vim.api.nvim_feedkeys("zz", "n", false)
end)

nnoremap("<leader>dp", function()
    vim.diagnostic.goto_prev({})
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next error diagnostic
nnoremap("]e", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous error diagnostic
nnoremap("[e", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto next warning diagnostic
nnoremap("]w", function()
    vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous warning diagnostic
nnoremap("[w", function()
    vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Open the diagnostic under the cursor in a float window
nnoremap("<leader>d", function()
    vim.diagnostic.open_float({
        border = "rounded",
    })
end)

-- Place all dignostics into a qflist
nnoremap("<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })

-- Navigate to next qflist item
nnoremap("<leader>cn", ":cnext<cr>zz")

-- Navigate to previos qflist item
nnoremap("<leader>cp", ":cprevious<cr>zz")

-- Open the qflist
nnoremap("<leader>co", ":copen<cr>zz")

-- Close the qflist
nnoremap("<leader>cc", ":cclose<cr>zz")

-- Resize split windows to be equal size
nnoremap("<leader>=", "<C-w>=")
-- Resize windows horizontally
-- Increase window width by 2 columns
vim.api.nvim_set_keymap('n', '<C-w>l', ':vertical resize +5<CR>', { noremap = true, silent = true })
-- Decrease window width by 2 columns
vim.api.nvim_set_keymap('n', '<C-w>h', ':vertical resize -5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>=', ':vertical resize<CR>', { noremap = true, silent = true })

-- Resize windows vertically
vim.api.nvim_set_keymap('n', '<C-w>j', ':resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>k', ':resize -5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>+', ':resize +5<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>-', ':resize -5<CR>', { noremap = true, silent = true })

-- Press leader f to format
nnoremap("<leader>f", function()
    conform.format({ async = true, lsp_fallback = true })
end, { desc = "Format the current buffer" })

-- Press leader rw to rotate open windows
-- nnoremap("<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows" })
--
-- -- Press gx to open the link under the cursor
-- nnoremap("gx", ":sil !open <cWORD><cr>", { silent = true })

-- TSC autocommand keybind to run TypeScripts tsc
-- Harpoon keybinds --
-- Open harpoon ui
nnoremap("<leader>ho", function()
    harpoon_ui.toggle_quick_menu()
end)

-- Add current file to harpoon
nnoremap("<leader>ha", function()
    harpoon_mark.add_file()
end)

-- Remove current file from harpoon
nnoremap("<leader>hr", function()
    harpoon_mark.rm_file()
end)

-- Remove all files from harpoon
nnoremap("<leader>hc", function()
    harpoon_mark.clear_all()
end)

-- Quickly jump to harpooned files
nnoremap("<leader>1", function()
    harpoon_ui.nav_file(1)
end)

nnoremap("<leader>2", function()
    harpoon_ui.nav_file(2)
end)

nnoremap("<leader>3", function()
    harpoon_ui.nav_file(3)
end)

nnoremap("<leader>4", function()
    harpoon_ui.nav_file(4)
end)

nnoremap("<leader>5", function()
    harpoon_ui.nav_file(5)
end)

nnoremap("<leader>hn", function()
    harpoon_ui.nav_next()
end)

nnoremap("<leader>hp", function()
    harpoon_ui.nav_prev()
end)

-- Git keymaps --
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<cr>")
nnoremap("<leader>gf", function()
    local cmd = {
        "sort",
        "-u",
        "<(git diff --name-only --cached)",
        "<(git diff --name-only)",
        "<(git diff --name-only --diff-filter=U)",
    }

    if not utils.is_git_directory() then
        vim.notify(
            "Current project is not a git directory",
            vim.log.levels.WARN,
            { title = "Telescope Git Files", git_command = cmd }
        )
    else
        require("telescope.builtin").git_files()
    end
end, { desc = "Search [G]it [F]iles" })

-- Telescope keybinds --
nnoremap("<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch Open [B]uffers" })
nnoremap("<leader>sf", function()
    require("telescope.builtin").find_files({ hidden = true })
end, { desc = "[S]earch [F]iles" })
nnoremap("<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
nnoremap("<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })

nnoremap("<leader>sc", function()
    require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
        previewer = false,
    }))
end, { desc = "[S]earch [C]ommands" })

nnoremap("<leader>/", function()
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer]" })

nnoremap("<leader>ss", function()
    require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
        previewer = false,
    }))
end, { desc = "[S]earch [S]pelling suggestions" })

-- LSP Keybinds (exports a function to be used in ../../after/plugin/lsp.lua b/c we need a reference to the current buffer) --
M.map_lsp_keybinds = function(buffer_number)
    nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
    nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })

    nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })

    -- Telescope LSP keybinds --
    nnoremap(
        "gr",
        require("telescope.builtin").lsp_references,
        { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
    )

    nnoremap(
        "gi",
        require("telescope.builtin").lsp_implementations,
        { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
    )

    nnoremap(
        "<leader>bs",
        require("telescope.builtin").lsp_document_symbols,
        { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
    )

    nnoremap(
        "<leader>ps",
        require("telescope.builtin").lsp_workspace_symbols,
        { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
    )

    -- See `:help K` for why this keymap
    nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
    nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
    nnoremap("<leader>dh", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
    inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })

    -- Lesser used LSP functionality
    nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
    nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

-- Symbol Outline keybind
nnoremap("<leader>so", ":SymbolsOutline<cr>")

-- Open Copilot panel
-- nnoremap("<leader>oc", function()
-- require("copilot.panel").open({})
-- end, { desc = "[O]pen [C]opilot panel" })

-- Insert --
-- Map jj to <esc>
inoremap("jj", "<esc>")
-- inoremap("jk", "<esc>")
-- inoremap("kk", "<esc>")

-- Visual --
-- Disable Space bar since it'll be used as the leader key
-- vnoremap("<space>", "<nop>")

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vnoremap("L", "$<left>")
vnoremap("H", "^")

-- Paste without losing the contents of the register
vnoremap("<leader><A-j>", ":m '>+1<CR>gv=gv")
vnoremap("<leader><A-k>", ":m '<-2<CR>gv=gv")

xnoremap("<leader>p", '"_dP')

-- Reselect the last visual selection
xnoremap("<<", function()
    -- Move selected text up/down in visual mode
    vim.cmd("normal! <<")
    vim.cmd("normal! gv")
end)

xnoremap(">>", function()
    vim.cmd("normal! >>")
    vim.cmd("normal! gv")
end)

-- Terminal --
-- Enter normal mode while in a terminal
tnoremap("<esc>", [[<C-\><C-n>]])
tnoremap("jj", [[<C-\><C-n>]])

-- Window navigation from terminal
-- tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]])
-- tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]])
-- tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]])
-- tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]])

nnoremap("<A-k>", ":m-2<CR>")
nnoremap("<A-j>", ":m+1<CR>")
-- vnoremap("<A-k>", ":m-2<CR>")
-- vnoremap("<A-j>", ":m+1<CR>")
vnoremap("<A-k>", ":m\'<-2<CR>gv=gv")
vnoremap("<A-j>", ":m\'>+1<CR>gv=gv")

nnoremap("<leader>x", "q:")
nnoremap("<leader><leader>", ":!")

-- Reenable default <space> functionality to prevent input delay
tnoremap("<space>", "<space>")

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}
local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }
require("ibl").setup { scope = { highlight = highlight } }

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
return M
