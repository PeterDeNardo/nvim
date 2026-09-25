-- Define a tecla líder (Espaço) antes de qualquer outra coisa
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Configurações Nativas do Editor
vim.opt.number = true          -- Mostra o número da linha atual
vim.opt.relativenumber = true  -- Linhas relativas (ótimo para pular linhas rápido)

vim.opt.tabstop = 2            -- Define que o Tab vale 2 espaços
vim.opt.shiftwidth = 2         -- Define o tamanho da indentação automática
vim.opt.expandtab = true       -- Transforma Tabs em espaços simples

vim.opt.mouse = "a"            -- Ativa o uso do mouse no editor
vim.opt.clipboard = "unnamedplus" -- Sincroniza o control+c / control+v com o Windows
vim.opt.ignorecase = true      -- Ignora maiúsculas/minúsculas ao buscar texto
vim.opt.smartcase = true       -- Diferencia maiúsculas se você digitar uma letra maiúscula

vim.opt.termguicolors = true   -- Ativa suporte a cores modernas de 24 bits

-- lint
vim.g.lazyvim_eslint_auto_format = true

-- Garante que as novas divisões de tela abram nos lugares certos (embaixo e na direita)
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Atalhos para abrir o terminal dividindo a tela automaticamente
vim.keymap.set('n', '<leader>th', '<cmd>split | terminal<cr>', { desc = "Terminal na Horizontal (Embaixo)" })
vim.keymap.set('n', '<leader>tv', '<cmd>vsplit | terminal<cr>', { desc = "Terminal na Vertical (Direita)" })
-- Tecla ESC para sair do modo de digitação do terminal (libera o cursor para navegar)
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { desc = "Sair do modo terminal" })

