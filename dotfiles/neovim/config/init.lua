-- Pure nvim config

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.timeoutlen = 1000

-- Since space is mapped to be the leader key, prevent it from performing any other operations
vim.keymap.set("n", "<Space>", "<nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Space>", "<nop>", { noremap = true, silent = true })

vim.opt.mouse = "nvi"

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

-- Manually control search results
vim.opt.incsearch = true
vim.opt.ignorecase = false
vim.opt.infercase = false
vim.opt.smartcase = false

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
      local catppuccin_final_opts = vim.tbl_deep_extend("force", catppuccin.default_options, opts)
      catppuccin.setup(catppuccin_final_opts)

      -- Activate the colorscheme
      vim.cmd.colorscheme("catppuccin")
    end,
  }
)

--- mini
local mini_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.mini",
  {
    config = function(lazy_plugin, opts)
      ---- mini.ai
      require("mini.ai").setup({
        -- Docs and config options:
        -- - https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md
        -- - :help mini.ai

        -- Table with textobject id as fields, textobject specification as values.
        -- Also use this to disable builtin textobjects. See |MiniAi.config|.
        custom_textobjects = nil,

        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
          -- Main textobject prefixes
          around = "a",
          inside = "i",

          -- Next/last variants
          around_next = "an",
          inside_next = "in",
          around_last = "al",
          inside_last = "il",

          -- Move cursor to corresponding edge of `a` textobject
          goto_left = "g[",
          goto_right = "g]",
        },

        -- Number of lines within which textobject is searched
        n_lines = 50,

        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of "cover", "cover_or_next", "cover_or_prev",
        -- "cover_or_nearest", "next", "previous", "nearest".
        search_method = "cover_or_next",

        -- Whether to disable showing non-error feedback
        -- This also affects (purely informational) helper messages shown after
        -- idle time if user input is required.
        silent = false,
      })

      ---- mini.align
      require("mini.align").setup({
        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
          start = "ga",
          start_with_preview = "gA",
        },

        -- Modifiers changing alignment steps and/or options
        -- modifiers = {
        --   -- Main option modifiers
        --   ["s"] = --<function: enter split pattern>,
        --   ["j"] = --<function: choose justify side>,
        --   ["m"] = --<function: enter merge delimiter>,

        --   -- Modifiers adding pre-steps
        --   ["f"] = --<function: filter parts by entering Lua expression>,
        --   ["i"] = --<function: ignore some split matches>,
        --   ["p"] = --<function: pair parts>,
        --   ["t"] = --<function: trim parts>,

        --   -- Delete some last pre-step
        --   ["<BS>"] = --<function: delete some last pre-step>,

        --   -- Special configurations for common splits
        --   ["="] = --<function: enhanced setup for "=">,
        --   [","] = --<function: enhanced setup for ",">,
        --   ["|"] = --<function: enhanced setup for "|">,
        --   [" "] = --<function: enhanced setup for " ">,
        -- },

        -- Default options controlling alignment process
        options = {
          split_pattern = "",
          justify_side = "left",
          merge_delimiter = "",
        },

        -- Default steps performing alignment (if `nil`, default is used)
        steps = {
          pre_split = {},
          split = nil,
          pre_justify = {},
          justify = nil,
          pre_merge = {},
          merge = nil,
        },

        -- Whether to disable showing non-error feedback
        -- This also affects (purely informational) helper messages shown after
        -- idle time if user input is required.
        silent = false,
      })

      ---- mini.comment
      require("mini.comment").setup({
        -- Options which control module behavior
        options = {
          -- Function to compute custom "commentstring" (optional)
          custom_commentstring = nil,

          -- Whether to ignore blank lines when commenting
          ignore_blank_line = true,

          -- Whether to ignore blank lines in actions and textobject
          start_of_line = false,

          -- Whether to force single space inner padding for comment parts
          pad_comment_parts = true,
        },

        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
          -- Toggle comment (like `gcip` - comment inner paragraph) for both
          -- Normal and Visual modes
          comment = "gc",

          -- Toggle comment on current line
          comment_line = "gcc",

          -- Toggle comment on visual selection
          comment_visual = "gc",

          -- Define "comment" textobject (like `dgc` - delete whole comment block)
          -- Works also in Visual mode if mapping differs from `comment_visual`
          textobject = "gc",
        },

        -- Hook functions to be executed at certain stage of commenting
        -- hooks = {
        --   -- Before successful commenting. Does nothing by default.
        --   pre = function() end,
        --   -- After successful commenting. Does nothing by default.
        --   post = function() end,
        -- },
      })

      ---- mini.move
      require("mini.move").setup({
        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
          -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
          left = "<M-h>",
          right = "<M-l>",
          down = "<M-j>",
          up = "<M-k>",

          -- Move current line in Normal mode
          line_left = "<M-h>",
          line_right = "<M-l>",
          line_down = "<M-j>",
          line_up = "<M-k>",
        },

        -- Options which control moving behavior
        options = {
          -- Automatically reindent selection during linewise vertical move
          reindent_linewise = true,
        },
      })

      ---- mini.pairs
      require("mini.pairs").setup({
        -- In which modes mappings from this `config` should be created
        modes = { insert = true, command = false, terminal = false },

        -- Global mappings. Each right hand side should be a pair information, a
        -- table with at least these fields (see more in |MiniPairs.map|):
        -- - <action> - one of "open", "close", "closeopen".
        -- - <pair> - two character string for pair to be used.
        -- By default pair is not inserted after `\`, quotes are not recognized by
        -- <CR>, `"` does not insert pair after a letter.
        -- Only parts of tables can be tweaked (others will use these defaults).
        mappings = {
          ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
          ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
          ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

          [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
          ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
          ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

          ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
          ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
          ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
        },
      })

      ---- mini.splitjoin
      require("mini.splitjoin").setup({
        -- Module mappings. Use `""` (empty string) to disable one.
        -- Created for both Normal and Visual modes.
        mappings = {
          toggle = "gS",
          split = "<leader>S",
          join = "<leader>J",
        },

        -- Detection options: where split/join should be done
        detect = {
          -- Array of Lua patterns to detect region with arguments.
          -- Default: { "%b()", "%b[]", "%b{}" }
          brackets = nil,

          -- String Lua pattern defining argument separator
          separator = ",",

          -- Array of Lua patterns for sub-regions to exclude separators from.
          -- Enables correct detection in presence of nested brackets and quotes.
          -- Default: { "%b()", "%b[]", "%b{}", '%b""', "%b''" }
          exclude_regions = nil,
        },

        -- Split options
        -- split = {
        --   hooks_pre = {},
        --   hooks_post = {},
        -- },

        -- -- Join options
        -- join = {
        --   hooks_pre = {},
        --   hooks_post = {},
        -- },
      })

      ---- mini.basics
      require("mini.basics").setup({
        -- Options. Set to `false` to disable.
        options = {
          -- Basic options ('number', 'ignorecase', and many more)
          basic = true,

          -- Extra UI features ('winblend', 'listchars', 'pumheight', ...)
          extra_ui = false,

          -- Presets for window borders ('single', 'double', ...)
          win_borders = 'default',
        },

        -- Mappings. Set to `false` to disable.
        mappings = {
          -- Basic mappings (better 'jk', save with Ctrl+S, ...)
          basic = true,

          -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
          -- Supply empty string to not create these mappings.
          option_toggle_prefix = [[\]],

          -- Window navigation with <C-hjkl>, resize with <C-arrow>
          windows = false,

          -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
          move_with_alt = false,
        },

        -- Autocommands. Set to `false` to disable
        autocommands = {
          -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
          basic = false,

          -- Set 'relativenumber' only in linewise and blockwise Visual mode
          relnum_in_visual_mode = false,
        },

        -- Whether to disable showing non-error feedback
        silent = false,
      })

      ---- mini.cursorword
      require("mini.cursorword").setup({
        -- Set `vim.g.minicursorword_disable` or `vim.b.minicursorword_disable` to `false` to disable globally or locally respectively.

        -- Delay (in ms) between when cursor moved and when highlighting appeared
        delay = 100,
      })

      ---- mini.statusline
      require("mini.statusline").setup({
        -- Content of statusline as functions which return statusline string. See
        -- `:h statusline` and code of default contents (used instead of `nil`).
        -- content = {
        --   -- Content for active window
        --   active = nil,
        --   -- Content for inactive window(s)
        --   inactive = nil,
        -- },

        -- Whether to use icons by default
        use_icons = true,

        -- Whether to set Vim's settings for statusline (make it always shown)
        set_vim_settings = true,
      })

      ---- mini.trailspace
      require("mini.trailspace").setup({
        -- Highlight only in normal buffers (ones with empty 'buftype'). This is
        -- useful to not show trailing whitespace where it usually doesn't matter.
        only_in_normal_buffers = true,
      })

      ----- mini.trailspace keymaps
      vim.keymap.set("n", "<leader><leader>tw", MiniTrailspace.trim)
      vim.keymap.set("n", "<leader><leader>tl", MiniTrailspace.trim_last_lines)
      vim.keymap.set(
        "n",
        "<leader><leader>ta",
        function()
          MiniTrailspace.trim()
          MiniTrailspace.trim_last_lines()
        end
      )

      ---- mini.icons
      require("mini.icons").setup({
        -- Icon style: 'glyph' or 'ascii'
        style = 'glyph',

        -- Customize per category. See `:h MiniIcons.config` for details.
        -- default   = {},
        -- directory = {},
        -- extension = {},
        -- file      = {},
        -- filetype  = {},
        -- lsp       = {},
        -- os        = {},

        -- Control which extensions will be considered during "file" resolution
        use_file_extension = function(ext, file) return true end,
      })
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
