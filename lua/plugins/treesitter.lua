return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Atualiza os parsers automaticamente ao instalar
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        -- Garante a instalação dos parsers para as linguagens que você usa
        ensure_installed = { 
          "lua", 
          "vim", 
          "vimdoc", 
          "query", 
          "javascript", 
          "typescript", 
          "c", 
          "python" 
        },
        
        -- Sincroniza a instalação (mantenha false para não travar o nvim)
        sync_install = false,

        -- Instala automaticamente linguagens novas se você abrir um arquivo delas
        auto_install = true,

        -- Ativa o realce de sintaxe do Treesitter
        highlight = {
          enable = true,
          -- Desativa em arquivos gigantes se começar a travar
          additional_vim_regex_highlighting = false,
        },
        
        -- Ativa a indentação inteligente baseada no Treesitter
        indent = { enable = true },
      })
    end,
  },
}

