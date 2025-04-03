-- Pure nvim config

vim.g.mapleader = "<space>"
vim.g.maplocalleader = "<space>"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5

vim.opt.shiftwidth = 2
vim.opt.autoindent = true
-- Have fine-grained control over spaces in normal mode. Prioritize simpler
-- control over code structure in insert.
vim.opt.smarttab = true
-- Indent with spaces by default. CTRL-V<Tab> to force insert tab when this is
-- on. Can ba overridden for specific fyletypes, if the language requres tabs
-- for indentations.
vim.opt.expandtab = true

-- TODO: set this per filetype
vim.opt.textwidth = 0

vim.opt.fixendofline = true

vim.opt.list = true
vim.opt.listchars = {
  tab = "➡⇨",
  space = "⸱",
  trail = "⚬",
  extends = "⤑",
  precedes = "⬸",
  nbsp = "⍽",
}

vim.opt.langremap = false
vim.opt.langmap = {
  -- Ukrainian 🇺🇦
  "'`",
        "йq", "цw", "уe", "кr", "еt", --[[ | ]] "нy", "гu", "шi", "щo",   "зp",   "х[", "ї]", "ґ\\",
        "фa", "іs", "вd", "аf", "пg", --[[ | ]] "рh", "оj", "лk", "дl",   "ж\\;", "є'",
        "яz", "чx", "сc", "мv",       --[[ | ]] "иb", "тn", "ьm", "б\\,", "ю.",

  "ʼ~",
        "ЙQ", "ЦW", "УE", "КR", "ЕT", --[[ | ]] "НY", "ГU", "ШI", "ЩO", "ЗP", "Х{",   "Ї}", "Ґ\\|",
        "ФA", "ІS", "ВD", "АF", "ПG", --[[ | ]] "РH", "ОJ", "ЛK", "ДL", "Ж:", 'Є\\"',
        "ЯZ", "ЧX", "СC", "МV",       --[[ | ]] "ИB", "ТN", "ЬM", "Б<", "Ю>",

  -- Cyrillic
  "ё`",
        "йq", "цw", "уe", "кr", "еt", --[[ | ]] "нy", "гu", "шi", "щo",   "зp",   "х[", "ъ]",
        "фa", "ыs", "вd", "аf", "пg", --[[ | ]] "рh", "оj", "лk", "дl",   "ж\\;", "э'",
        "яz", "чx", "сc", "мv",       --[[ | ]] "иb", "тn", "ьm", "б\\,", "ю.",

  "Ё~",
        "ЙQ", "ЦW", "УE", "КR", "ЕT", --[[ | ]] "НY", "ГU", "ШI", "ЩO", "ЗP", "Х{",   "Ъ}",
        "ФA", "ЫS", "ВD", "АF", "ПG", --[[ | ]] "РH", "ОJ", "ЛK", "ДL", "Ж:", 'Э\\"',
        "ЯZ", "ЧX", "СC", "МV",       --[[ | ]] "ИB", "ТN", "ЬM", "Б<", "Ю>",
}

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 50 }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Configure help pages",
  group = vim.api.nvim_create_augroup("help-file-type", { clear = true }),
  pattern = "help",
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
})

-- nvimpager
if nvimpager then
  nvimpager.maps = false
end

-- Plugin management

--- Plugins declaration and config
bpu = require("config.infra.utils")

---- Catppuccin
local catppuccin_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.catppuccin",
  {
    -- Config: https://github.com/catppuccin/nvim
    opts = {
      flavour = "auto",
      background = {
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = true,
      term_colors = false,
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      default_integrations = false,
      intergrations = {
        fzf = true,
        gitsigns = true,
        harpoon = true,
        render_markdown = true,
        markdown = true,
        mini = {
          enabled = true,
        },
        dap = true,
        dap_ui = true,
        native_lsp = {
          enabled = true,
        },
        semantic_tokens = true,
        nvim_surround = true,
        treesitter_context = true,
        treesitter = true,
        telescope = {
          enabled = true,
          -- style = "",
        },
        which_key = true,
        -- TODO: does LSP already does this?
        -- illuminate = {
        --   enabled = true,
        --   lsp = true,
        -- },
      },
    },
    config = function(lazy_plugin, opts)
      -- Call the original plugin's setup code
      local catppuccin = require(lazy_plugin.name)
      catppuccin.setup(vim.tbl_deep_extend("force", catppuccin.default_options, opts))

      -- Activate the colorscheme
      vim.cmd.colorscheme("catppuccin")
    end,
  }
)

--- Initialize lazy.nvim plugin manager
local lazy_plugin_infra = require("config.infra.lazy")
lazy_plugin_infra.setup_plugins({
  -- All options: https://lazy.folke.io/configuration
  spec = bpu.final_lazy_spec,
  install = {
    missing = true,
  },
  rocks = {
    enabled = true,
  },
  checker = {
    -- Enable autoupdate for plugins
    enabled = true,
  },
})

-- TODO:
--   - highlight trailing spaces in red
