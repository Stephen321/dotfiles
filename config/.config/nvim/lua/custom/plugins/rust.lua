return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    config = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          on_attach = function(client, bufnr)
            -- vim.keymap.set('n', '<leader>ca', function()
            --   vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
            --   -- or vim.lsp.buf.codeAction() if you don't want grouping.
            -- end, { silent = true, buffer = bufnr })
            vim.keymap.set(
              'n',
              'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
              function()
                vim.cmd.RustLsp { 'hover', 'actions' }
              end,
              { silent = true, buffer = bufnr }
            ) -- you can also put keymaps in here
          end,
          -- see :h rustaceanvim.mason
          cmd = function()
            local mason_registry = require 'mason-registry'
            if mason_registry.is_installed 'rust-analyzer' then
              -- This may need to be tweaked depending on the operating system.
              local ra = mason_registry.get_package 'rust-analyzer'
              local ra_filename = ra:get_receipt():get().links.bin['rust-analyzer']
              return { ('%s/%s'):format(ra:get_install_path(), ra_filename or 'rust-analyzer') }
            else
              -- global installation
              return { 'rust-analyzer' }
            end
          end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {},
          },
        },
        -- DAP configuration
        dap = {},
      }
    end,
    --   vim.api.nvim_create_autocmd('LspAttach', {
    --
    --     group = vim.api.nvim_create_augroup('rustaceanvim-lsp-attach', { clear = true }),
    --     callback = function(event)
    --       local map = function(keys, func, desc, mode)
    --         mode = mode or 'n'
    --         vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    --       end
    --       map('<leader>a', function()
    --         vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
    --         -- or vim.lsp.buf.codeAction() if you don't want grouping.
    --       end)
    --       map('K', function() -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
    --         vim.cmd.RustLsp { 'hover', 'actions' }
    --       end)
    --     end,
    --   })
    -- end,
  },
}
