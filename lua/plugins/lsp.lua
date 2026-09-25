return {
  -- 1. O Plugin Principal (Mason) e todas as suas dependências juntas
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- Configuração do Mason UI
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      -- Configuração do Mason LSPConfig (Lista de LSPs para instalar)
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "lua_ls",   -- Para Lua e Neovim API
          "vimls",    -- Para arquivos .vim (Vimscript)
          "jsonls",   -- Para arquivos .json
          "pyright",  -- Para Python (Tipagem e intelisense rápido)
          "eslint",
        },
        automatic_installation = true,
      })

      -- Configuração do Mason Tool Installer (Formatadores e Linters extras)
      require("mason-tool-installer").setup({
        ensure_installed = {
          -- Utilitários globais que você já usava
          "stylua",               -- Formatador para Lua
          "shellcheck",
          "editorconfig-checker",
          "luacheck",
          "prettier",             -- Formatador para JSON, Markdown, JS, etc.
          -- Python Extras
          "black",                -- Formatador padrão do ecossistema Python
          "isort",                -- Organiza os imports do Python automaticamente
        },
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 5,
      })

      -- Configuração Global do LSPConfig (Atalhos de teclado)
      local lspconfig = require("lspconfig")
      if pcall(require, "cmp_nvin_lsp") then 
        capabilities = require("cmp_nvin_lsp").default.capabilities
      end
      -- Função executada quando qualquer LSP se conecta a um arquivo aberto
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        
        -- Principais atalhos de navegação de código
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)     -- Ir para Definição
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)     -- Ver Referências
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)           -- Mostrar documentação/assinatura
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts) -- Renomear variáveis globalmente
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts) -- Ações corretivas do código
      end

      -- =====================================================================
      -- TRATATIVAS INDIVIDUAIS POR LINGUAGEM
      -- =====================================================================

      -- 1. Servidor de Lua (Configurado especificamente para desenvolvimento de Neovim)
      lspconfig.lua_ls.setup({
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT", -- O Neovim roda internamente em LuaJIT
            },
            diagnostics = {
              globals = { "vim" }, -- Remove o aviso irritante de 'undefined global vim'
            },
            workspace = {
              -- Faz o LSP entender as funções nativas e APIs do Neovim (ex: vim.api.*)
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- 2. Servidor do Vimscript (Arquivos de configuração .vim antigos ou legados)
      lspconfig.vimls.setup({
        on_attach = on_attach,
      })

      -- 3. Servidor de JSON (Com capacidades nativas de entender schemas)
      lspconfig.jsonls.setup({
        on_attach = on_attach,
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      })

      -- 4. Servidor de Python (Pyright)
      lspconfig.pyright.setup({
        on_attach = on_attach,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace", -- Analisa erros no projeto inteiro, não só no arquivo aberto
            },
          },
        },
      })
      
      -- Serv ESLint
      lspconfig.eslint.setup({
        on_attach = on_attach,
        settings = {
          eslint = {
            enable = true,
            format = { enable = true }, -- Permite que o ESLint atue como formatador de código
            packageManager = "npm",
            autoFixOnSave = true,       -- Aplica correções rápidas automaticamente ao salvar
            codeActionOnSave = {
              enable = true,
              mode = "all"
            },
            workingDirectories = { mode = "location" }, -- Resolve caminhos em monorepos ou subpastas
            diagnostic = {
              workingDirectory = { mode = "location" }
            }
          },
        },
      })
    end, -- Fim da função config
  },
}
