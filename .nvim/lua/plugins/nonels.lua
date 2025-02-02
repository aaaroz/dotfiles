return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        -- setting formater yang akan dipakai

        null_ls.setup({
            sources = {
                -- stylua
                null_ls.builtins.formatting.stylua,

                -- prettier
                null_ls.builtins.formatting.prettier.with({
                    filetypes = {
                        "css",
                        "html",
                        "javascript",
                        "javascriptreact",
                        "typescript",
                        "typescriptreact",
                        "json",
                        "yaml",
                    },
                    extra_args = { "--tab-width", "2" },
                    dynamic_command = function()
                        return "prettier"
                    end,
                }),
            },
        })

        -- Auto format saat file disimpan
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            callback = function()
                vim.lsp.buf.format({ async = false }) -- Format sebelum file ditulis (sinkron)
            end,
        })

        vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
    end,
}
