local servers = { "lua_ls", "pyright" }
return {
    {
        "neovim/nvim-lspconfig",
        name = "nvim-lspconfig",
        dependencies  = {
            "hrsh7th/cmp-nvim-lsp",
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        opts = {
            servers = {
            lua_ls = {
                settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                telemetry = { enable = false },
                },
            },
            pyright = {},
            },
        },
        config = function()
            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }

                -- 基本快捷键
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format { async = true }
                end, opts)
            end
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            for _, server in ipairs(servers) do
            require("lspconfig")[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
            end
        end




    },
    {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            }
        }
    }
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            automatic_enable = false,
            ensure_installed = servers,
            automatic_installation = true,
        },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
    },
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({})
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    }
}