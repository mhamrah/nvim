local Util = require("hamrah.util")
local km = vim.keymap
local opts = { silent = true }

km.set("", "n", "h", opts)
km.set("", "e", "j", opts)
km.set("", "i", "k", opts)
km.set("", "o", "l", opts)

km.set("", "h", "i", opts)
km.set("", "l", "n", opts)
km.set("n", "k", "o", opts)
km.set("", "j", "e", opts)

km.set("i", "jj", "<Esc>", opts)

-- Move to window using the <ctrl> hjkl keys
km.set("n", "<C-n>", "<C-w>h", { desc = "Go to left window" })
km.set("n", "<C-e>", "<C-w>j", { desc = "Go to lower window" })
km.set("n", "<C-i>", "<C-w>k", { desc = "Go to upper window" })
km.set("n", "<C-o>", "<C-w>l", { desc = "Go to right window" })

-- Move Lines
km.set("n", "<A-e>", "<cmd>m .+1<cr>==", { desc = "Move down" })
km.set("n", "<A-i>", "<cmd>m .-2<cr>==", { desc = "Move up" })
km.set("i", "<A-e>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
km.set("i", "<A-i>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
km.set("v", "<A-e>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
km.set("v", "<A-i>", ":m '<-2<cr>gv=gv", { desc = "Move up" })


km.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
km.set('n', 'i', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
km.set('n', 'e', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--km.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- windows
km.set("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
km.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
km.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
km.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
km.set("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
km.set("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- buffers
if Util.has("bufferline.nvim") then
  km.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  km.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
  km.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
  km.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
else
  km.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  km.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
  km.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
  km.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
end
km.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- Clear search with <esc>
km.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- save file
km.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
km.set("v", "<", "<gv")
km.set("v", ">", ">gv")

-- lazy
km.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

km.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
km.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })
km.set("n", "<leader>xqc", "<cmd>cclose<cr>", { desc = "Quickfix Close" })

-- toggle options
-- km.set("n", "<leader>uf", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })
-- km.set("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
-- km.set("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
-- km.set("n", "<leader>ul", function() Util.toggle("relativenumber", true) Util.toggle("number") end, { desc = "Toggle Line Numbers" })
-- km.set("n", "<leader>ud", Util.toggle_diagnostics, { desc = "Toggle Diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- km.set("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
--
-- quit
km.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
