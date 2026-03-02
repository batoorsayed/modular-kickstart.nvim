-- https://github.com/folke/lazydev.nvim
-- https://github.com/mason-org/mason.nvim
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
-- https://github.com/j-hui/fidget.nvim
-- https://github.com/Saghen/blink.cmp

return {
    {
        -- Main LSP Configuration
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs and related tools to stdpath for Neovim
            -- Mason must be loaded before its dependents so we need to set it up here.
            -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
            {
                'mason-org/mason.nvim',
                ---@module 'mason.settings'
                ---@type MasonSettings
                ---@diagnostic disable-next-line: missing-fields
                opts = {},
            },
            -- Maps LSP server names between nvim-lspconfig and Mason package names.
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            -- Useful status updates for LSP.
            { 'j-hui/fidget.nvim', opts = {} },

            -- Allows extra capabilities provided by blink.cmp
            'saghen/blink.cmp',
        },
        config = function()
            --  This function gets run when an LSP attaches to a particular buffer.
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
                callback = function(event)
                    -- Create a function that define mappings specific for LSP related items. It sets the mode, buffer and description.
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    -- Rename the variable under your cursor.
                    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

                    -- Execute a code action, usually your cursor needs to be on top of an error
                    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

                    -- This is not Goto Definition, this is Goto Declaration.
                    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

                    --Autocommands are used to highlight references of the word under your cursor when your cursor rests.
                    --    See `:help CursorHold` for information about when this is executed
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
                        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight',
                            { clear = false })
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        -- When you move your cursor the highlights will be cleared
                        local client = vim.lsp.get_client_by_id(event.data.client_id)
                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            buffer = event.buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })

                        vim.api.nvim_create_autocmd('LspDetach', {
                            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                            callback = function(event2)
                                vim.lsp.buf.clear_references()
                                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
                            end,
                        })
                    end

                    -- The following code creates a keymap to toggle inlay hints in your code
                    if client and client:supports_method('textDocument/inlayHint', event.buf) then
                        map('<leader>th',
                            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end,
                            '[T]oggle Inlay [H]ints')
                    end
                end,
            })

            -- Enable the language servers
            --  See `:help lsp-config` for information about keys and how to configure
            ---@type table<string, vim.lsp.Config>
            local servers = {
                -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
                ty = {
                    -- ty language server settings go here
                },
                -- pyright = {
                --   settings = {
                --     python = {
                --       disableOrganizeImports = true,
                --       analysis = {
                --         typeCheckingMode = 'strict', -- 'off', default = 'basic', 'strict'
                --         autoSearchPaths = true, -- default = true
                --         useLibraryCodeForTypes = true,
                --         diagnosticMode = 'workspace', -- 'workspace', default = 'openFilesOnly'
                --       },
                --     },
                --   },
                -- },
                --
                stylua = {}, -- Used to format Lua code

                -- Special Lua Config, as recommended by neovim help docs
                lua_ls = {
                    on_init = function(client)
                        if client.workspace_folders then
                            local path = client.workspace_folders[1].name
                            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
                        end

                        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                            runtime = {
                                version = 'LuaJIT',
                                path = { 'lua/?.lua', 'lua/?/init.lua' },
                            },
                            workspace = {
                                checkThirdParty = false,
                                -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
                                --  See https://github.com/neovim/nvim-lspconfig/issues/3189
                                library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                                    '${3rd}/luv/library',
                                    '${3rd}/busted/library',
                                }),
                            },
                        })
                    end,
                    settings = {
                        Lua = {},
                    },
                },
            }
            -- To check the current status of installed tools and/or manually install other tools, you can run :Mason
            -- You can add other tools here that you want Mason to install
            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'ruff',         -- Used to format Python code
                'markdownlint', -- Markdown linter
            })
            require('mason-tool-installer').setup { ensure_installed = ensure_installed }

            for name, server in pairs(servers) do
                vim.lsp.config(name, server)
                vim.lsp.enable(name)
            end
        end,
    },
}
-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
