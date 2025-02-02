-- set leader key ke spasi
vim.g.mapleader = " "

-- set clipboard options
vim.opt.clipboard = "unnamedplus"
vim.o.wrap = false -- Display lines as one long line (default: true)
vim.o.linebreak = true -- Companion to wrap, don't split words (default: false)

-- set ukuran tab menjadi 4 spasi
vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

-- set powershell sebagai shell default
vim.o.shell = "powershell.exe"

vim.o.shellxquote = ""
vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
vim.o.shellquote = ""
vim.o.shellpipe = "| Out-File -Encoding UTF8 %s"
vim.o.shellredir = "| Out-File -Encoding UTF8 %s"

-- set relative line number
vim.wo.relativenumber = true
vim.opt.number = true

-- line break
vim.opt.breakindent = true
vim.opt.formatoptions:remove("t")
vim.opt.linebreak = true

-- incremental search
vim.opt.incsearch = true

-- terminal color
vim.opt.termguicolors = true

-- tampilin minimal 10 line terbawah pas scroll, kaya padding
vim.opt.scrolloff = 10

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- keymap pindah pindah window
-- pindah ke kanan
vim.keymap.set("n", "<C-h>", "<C-w>h", {})
-- pindah ke kiri
vim.keymap.set("n", "<C-l>", "<C-w>l", {})
-- pindah ke bawah
vim.keymap.set("n", "<C-j>", "<C-w>j", {})
-- pindah ke atas
vim.keymap.set("n", "<C-k>", "<C-w>k", {})

-- keymap untuk indent
vim.keymap.set("v", "<", "<gv", {})
vim.keymap.set("v", ">", ">gv", {})

-- escape terminal mode
vim.keymap.set("t", "<C-x>", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true))

-- line number
-- toggle lineNumber
vim.keymap.set("n", "<leader>n", "<cmd> set nu! <CR>")
-- toggle relativelinenumber
-- vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>")

-- matiin shift Q
vim.keymap.set("n", "Q", "<nop>")

-- biar text gak terlalu mepet ke bawah pas scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- biar text gak terlalu mepet ke atas pas scroll
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "J", "mzJ`z")

-- Pindahkan baris ke atas dengan Alt + Arrow Up
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { noremap = true, silent = true })

-- Pindahkan baris ke bawah dengan Alt + Arrow Down
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })

-- Pindahkan visual selected lines ke atas dengan Alt + Arrow Up
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- Pindahkan visual selected lines ke bawah dengan Alt + Arrow Down
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })

-- rustaceanvim
vim.keymap.set("n", "<Leader>dt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })

-- nvim dap
vim.keymap.set("n", "<Leader>dl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
vim.keymap.set("n", "<Leader>dj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
vim.keymap.set("n", "<Leader>dk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
vim.keymap.set("n", "<Leader>dc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
vim.keymap.set(
	"n",
	"<Leader>db",
	"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
	{ desc = "Debugger toggle breakpoint" }
)
vim.keymap.set(
	"n",
	"<Leader>dd",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
	{ desc = "Debugger set conditional breakpoint" }
)
vim.keymap.set("n", "<Leader>de", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
vim.keymap.set("n", "<Leader>dr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })

-- Custom code snippets for different purposes

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- Appearance of diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		-- Add a custom format function to show error codes
		format = function(diagnostic)
			local code = diagnostic.code and string.format("[%s]", diagnostic.code) or ""
			return string.format("%s %s", code, diagnostic.message)
		end,
	},
	underline = false,
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
	-- Make diagnostic background transparent
	on_ready = function()
		vim.cmd("highlight DiagnosticVirtualText guibg=NONE")
	end,
})

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
