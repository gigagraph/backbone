-- Pure nvim config

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.timeoutlen = 1000

-- Since space is mapped to be the leader key, prevent it from performing any other operations
vim.keymap.set("n", "<Space>", "<nop>", { noremap = true, silent = true })
vim.keymap.set("v", "<Space>", "<nop>", { noremap = true, silent = true })

vim.opt.mouse = "nvi"

vim.opt.wrap = true

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
  callback = function(ev)
    vim.highlight.on_yank { timeout = 50 }
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Configure help pages",
  group = vim.api.nvim_create_augroup("help-file-type", { clear = true }),
  pattern = "help",
  callback = function(ev)
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
      -- Color customizations
      color_overrides = {
        mocha = {
          -- Custom colorscheme based on catppuccin, but shifted more to the red rather than blue.
          -- It needs a custom name too - Catppuccin Cocoa.
          crust = "#191513",
          mantle = "#201b18",
          base = "#26201c",
          surface0 = "#443831",
          surface1 = "#5a4c45",
          surface2 = "#705f58",
          overlay0 = "#766660",
          overlay1 = "#91827e",
          overlay2 = "#b2a39f",
          subtext0 = "#c7aea7",
          subtext1 = "#e0c8c2",
          text = "#dad8d8",
          rosewater = "#ead7da",
          flamingo = "#edc4cb",
          pink = "#efb3d1",
          mauve = "#d985e0",
          red = "#db7072",
          maroon = "#e59d99",
          peach = "#f1ad83",
          yellow = "#ead28a",
          green = "#74b96e",
          teal = "#89cdc0",
          sky = "#7cc6de",
          sapphire = "#67b2e4",
          blue = "#668dcc",
          lavender = "#9c9dc9",
        },
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

---- plenary
local plenary_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.plenary",
  {}
)

---- mini
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

      ---- mini.surround
      require("mini.surround").setup({
        -- Add custom surroundings to be used on top of builtin ones. For more
        -- information with examples, see `:h MiniSurround.config`.
        -- custom_surroundings = nil,

        -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
        highlight_duration = 500,

        -- Module mappings. Use `""` (empty string) to disable one.
        mappings = {
          add = "<leader>sa", -- Add surrounding in Normal and Visual modes
          delete = "<leader>sd", -- Delete surrounding
          find = "<leader>sf", -- Find surrounding (to the right)
          find_left = "<leader>sF", -- Find surrounding (to the left)
          highlight = "<leader>sh", -- Highlight surrounding
          replace = "<leader>sr", -- Replace surrounding
          update_n_lines = "<leader>sn", -- Update `n_lines`

          suffix_last = "l", -- Suffix to search with "prev" method
          suffix_next = "n", -- Suffix to search with "next" method
        },

        -- Number of lines within which surrounding is searched
        n_lines = 20,

        -- Whether to respect selection type:
        -- - Place surroundings on separate lines in linewise mode.
        -- - Place surroundings on each line in blockwise mode.
        respect_selection_type = true,

        -- How to search for surrounding (first inside current line, then inside
        -- neighborhood). One of "cover", "cover_or_next", "cover_or_prev",
        -- "cover_or_nearest", "next", "prev", "nearest". For more details,
        -- see `:h MiniSurround.config`.
        search_method = "cover",

        -- Whether to disable showing non-error feedback
        -- This also affects (purely informational) helper messages shown after
        -- idle time if user input is required.
        silent = false,
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

---- nvim-treesitter-context
local nvim_treesitter_context_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.nvim-treesitter-context",
  {
    -- Configured later as a part of nvim-treesitter
  }
)

---- nvim-treesitter-textobjects
local nvim_treesitter_textobjects_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.nvim-treesitter-textobjects",
  {
    -- Configured later as a part of nvim-treesitter
  }
)

---- nvim-treesitter-refactor
local nvim_treesitter_refactor_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.nvim-treesitter-refactor",
  {
    -- Configured later as a part of nvim-treesitter
  }
)

---- nvim-treesitter
local nvim_treesitter_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.nvim-treesitter",
  {
    config = function(lazy_plugin, opts)
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          -- General
          "comment",

          -- Development
          --- Programming languages
          "c",
          "rust",
          "llvm",
          "lua",
          "haskell",
          "perl",

          --- C++
          "cpp",
          "doxygen",

          --- Zig
          "zig",
          "ziggy",
          "ziggy_schema",

          ---- Python
          "python",
          "requirements",
          -- Will possibly be avaialble after 0.9.3
          -- "jinja",
          -- "jinja_inline",

          ---- Go
          "go",
          "gosum",
          "gomod",
          "gotmpl",

          ---- JVM
          "java",
          -- Will possibly be avaialble after 0.9.3
          -- "javadoc",
          "scala",
          "kotlin",

          --- System scripting
          "bash",

          --- Formal

          ---- Model verification
          "tlaplus",

          ---- Proof
          -- Will possibly be avaialble after 0.9.3
          -- "idris",

          --- High-performance computing
          "cuda",

          --- Hardware definition
          "verilog",
          "vhdl",

          --- Web stack
          "javascript",
          "typescript",
          "html",
          "css",
          "scss",

          --- Query languages
          "promql",
          "sql",

          --- Protobuf
          "proto",

          --- Markdown
          "markdown",
          "markdown_inline",

          --- TeX
          "latex",
          "bibtex",

          -- nvim
          "vim",
          "vimdoc",

          --- Treesitter
          "query",

          -- Build systems
          "cmake",
          "make",
          "ninja",
          "starlark",

          -- DevOps
          "hcl",
          "terraform",
          "cue",
          "jsonnet",
          "helm",
          "dockerfile",
          "nix",

          --- Configuration formats for tools
          "editorconfig",
          "ssh_config",

          -- Policies
          "rego",

          -- Configuration format
          "hocon",
          "ini",
          "toml",
          "yaml",

          -- Data
          "csv",
          "xml",

          --- JSON
          "json",
          "json5",
          "jsonc",

          -- CLI tools
          "diff",
          "jq",

          --- Git
          -- Will possibly be avaialble after 0.9.3
          -- "gitconfig",
          -- "gitrebase",
          "gitattributes",
          "gitcommit",
          "gitignore",

          -- Protocols
          "http",

          -- System configuration
          "udev",
        },

        sync_install = false,
        auto_install = false,

        highlight = {
          enable = true,
          -- Disable highlighting for big files
          disable = function(lang, bufnr)
            local max_filesize_bytes = 2 * 1024 * 1024 -- 2 MB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
            if ok and stats and stats.size > max_filesize_bytes then
              return true
            end

            return false
          end,

          -- Disable native vim highilighitng for the filetypes that have treesitter grammars
          additional_vim_regex_highlighting = false,
        },

        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>vv",
            node_incremental = "<leader>vk",
            node_decremental = "<leader>vj",
            scope_incremental = "<leader>vp",
          },
        },

        indent = {
          enable = true
        },

        context = {
          -- https://github.com/nvim-treesitter/nvim-treesitter-context?tab=readme-ov-file#configuration
          enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
          multiwindow = true, -- Enable multiwindow support.
          max_lines = 5, -- How many lines the window should span. Values <= 0 mean no limit.
          min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
          line_numbers = true,
          multiline_threshold = 20, -- Maximum number of lines to show for a single context
          trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: "inner", "outer"
          mode = "cursor", -- Line used to calculate context. Choices: "cursor", "topline"
          -- Separator between context and content. Should be a single character string, like "-".
          -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
          separator = nil,
          zindex = 20, -- The Z-index of the context window
          on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        },

        textobjects = {
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@comment.outer",
              ["ic"] = "@comment.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["as"] = {
                query = "@local.scope",
                query_group = "locals",
                desc = "Select language scope",
              },
            },
            selection_modes = {},
            include_surrounding_whitespace = false, -- Note: can also be a function to have different behaviors for queries and selection modes
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader><leader>abn"] = "@block.outer",
              ["<leader><leader>abP"] = "@block.outer",
              ["<leader><leader>ibn"] = "@block.inner",
              ["<leader><leader>ibP"] = "@block.inner",
              ["<leader><leader>afn"] = "@function.outer",
              ["<leader><leader>afP"] = "@function.outer",
              ["<leader><leader>ifn"] = "@function.inner",
              ["<leader><leader>ifP"] = "@function.inner",
            },
            swap_previous = {
              ["<leader><leader>abp"] = "@block.outer",
              ["<leader><leader>abN"] = "@block.outer",
              ["<leader><leader>ibp"] = "@block.inner",
              ["<leader><leader>ibN"] = "@block.inner",
              ["<leader><leader>afp"] = "@function.outer",
              ["<leader><leader>afN"] = "@function.outer",
              ["<leader><leader>ifp"] = "@function.inner",
              ["<leader><leader>ifN"] = "@function.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.inner",
              ["]]"] = "@block.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.inner",
              ["]}"] = "@block.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.inner",
              ["[["] = "@block.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.inner",
              ["[{"] = "@block.outer",
            },
          },
          lsp_interop = {
            -- Disabled until LSP is integrated with the config.
            enable = false,
            floating_preview_opts = {
              border = "shadow",
            },
            peek_definition_code = {}
          },
        },

        refactor = {
          -- https://github.com/nvim-treesitter/nvim-treesitter-refactor
          highlight_definitions = {
            enable = true,
            clear_on_cursor_move = true, -- Set to false if you have an `updatetime` of ~100.
          },
          highlight_current_scope = {
            enable = true,
          },
          smart_rename = {
            enable = false,
            -- Assign keymaps to false to disable them, e.g. `smart_rename = false`. Otherwise assign to a keymapping.
            keymaps = {
              smart_rename = false,
            },
          },
          navigation = {
            enable = false,
            -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
            keymaps = {
              goto_definition_lsp_fallback = false,
              list_definitions = false,
              list_definitions_toc = false,
              goto_next_usage = false,
              goto_previous_usage = false,
            },
          },
        },
      })

      -- Function to check if treesitter parser exists for the current buffer's filetype
      local function buffer_has_treesitter_parser(bufnr)
        local bufnr = bufnr or vim.fn.bufnr("%")
        if vim.fn.bufexists(bufnr) == 0 then
          return false
        else
          local buf_ft = vim.bo[bufnr].filetype

          if buf_ft == "" then
            return false
          end
        end

        -- try to get parser for the current filetype
        local parser_ok, _ = pcall(vim.treesitter.get_parser, bufnr, buf_ft)

        return parser_ok
      end

      local treesitter_folding_expected_foldmethod = "expr"
      local treesitter_folding_expected_foldexpr = "v:lua.vim.treesitter.foldexpr()"
      local treesitter_folding_expected_foldlevel = 99
      local bkb_prev_foldmethod_buffer_var = "bkb_prev_foldmethod"
      local bkb_prev_foldexpr_buffer_var = "bkb_prev_foldexpr"
      local bkb_prev_foldlevel_buffer_var = "bkb_prev_foldlevel"

      local function try_enable_treesitter_folding(bufnr)
        local bufnr = bufnr or vim.fn.bufnr("%")

        if buffer_has_treesitter_parser(bufnr) then
          local win_id = vim.fn.bufwinid(bufnr)
          if win_id ~= -1 then
            local current_foldmethod = vim.wo[win_id].foldmethod
            local current_foldexpr = vim.wo[win_id].foldexpr
            local current_foldlevel = vim.wo[win_id].foldlevel

            local bkb_prev_foldmethod_ok, prev_foldmethod = pcall(
              vim.api.nvim_buf_get_var,
              bufnr,
              bkb_prev_foldmethod_buffer_var
            )
            local bkb_prev_foldexpr_ok, prev_foldexpr = pcall(
              vim.api.nvim_buf_get_var,
              bufnr,
              bkb_prev_foldexpr_buffer_var
            )
            local bkb_prev_foldlevel_ok, prev_foldlevel = pcall(
              vim.api.nvim_buf_get_var,
              bufnr,
              bkb_prev_foldlevel_buffer_var
            )
            local bkb_prev_vars_ok = (
              bkb_prev_foldmethod_ok and
              bkb_prev_foldexpr_ok and
              bkb_prev_foldlevel_ok
            )

            if not bkb_prev_vars_ok then
              vim.api.nvim_buf_set_var(bufnr, bkb_prev_foldmethod_buffer_var, current_foldmethod)
              vim.api.nvim_buf_set_var(bufnr, bkb_prev_foldexpr_buffer_var, current_foldexpr)
              vim.api.nvim_buf_set_var(bufnr, bkb_prev_foldlevel_buffer_var, current_foldlevel)
            end

            -- Enable treesitter folding
            vim.wo[win_id].foldmethod = treesitter_folding_expected_foldmethod
            vim.wo[win_id].foldexpr = treesitter_folding_expected_foldexpr
            vim.wo[win_id].foldlevel = treesitter_folding_expected_foldlevel
          end
        end
      end

      local function try_disable_treesitter_folding(bufnr)
        local bufnr = bufnr or vim.fn.bufnr("%")

        local win_id = vim.fn.bufwinid(bufnr)
        if win_id ~= -1 then
          local bkb_prev_foldmethod_ok, prev_foldmethod = pcall(
            vim.api.nvim_buf_get_var,
            bufnr,
            bkb_prev_foldmethod_buffer_var
          )
          local bkb_prev_foldexpr_ok, prev_foldexpr = pcall(
            vim.api.nvim_buf_get_var,
            bufnr,
            bkb_prev_foldexpr_buffer_var
          )
          local bkb_prev_foldlevel_ok, prev_foldlevel = pcall(
            vim.api.nvim_buf_get_var,
            bufnr,
            bkb_prev_foldlevel_buffer_var
          )
          local bkb_prev_vars_ok = (
          bkb_prev_foldmethod_ok and
          bkb_prev_foldexpr_ok and
          bkb_prev_foldlevel_ok
        )

          if bkb_prev_vars_ok then
            -- Revert the folding configuration back
            vim.wo[win_id].foldmethod = prev_foldmethod
            vim.wo[win_id].foldexpr = prev_foldexpr
            vim.wo[win_id].foldlevel = prev_foldlevel

            -- Delete the previous variables from the buffer
            local _, _ = pcall(vim.api.nvim_buf_del_var, bufnr, bkb_prev_foldmethod_buffer_var)
            local _, _ = pcall(vim.api.nvim_buf_del_var, bufnr, bkb_prev_foldexpr_buffer_var)
            local _, _ = pcall(vim.api.nvim_buf_del_var, bufnr, bkb_prev_foldlevel_buffer_var)
          end
        end
      end

      local function is_treesitter_folding_enabled(bufnr)
        local bufnr = bufnr or vim.fn.bufnr("%")

        local bkb_prev_foldmethod_ok, _ = pcall(
          vim.api.nvim_buf_get_var,
          bufnr,
          bkb_prev_foldmethod_buffer_var
        )
        local bkb_prev_foldexpr_ok, _ = pcall(
          vim.api.nvim_buf_get_var,
          bufnr,
          bkb_prev_foldexpr_buffer_var
        )
        local bkb_prev_foldlevel_ok, _ = pcall(
          vim.api.nvim_buf_get_var,
          bufnr,
          bkb_prev_foldlevel_buffer_var
        )
        return (
          bkb_prev_foldmethod_ok and
          bkb_prev_foldexpr_ok and
          bkb_prev_foldlevel_ok
        )
      end

      -- Function to toggle treesitter folding for the current buffer
      local function try_toggle_treesitter_folding(bufnr)
        local bufnr = bufnr or vim.fn.bufnr("%")

        if is_treesitter_folding_enabled(bufnr) then
          try_disable_treesitter_folding(bufnr)
        else
          try_enable_treesitter_folding(bufnr)
        end
      end

      -- Command to toggle treesitter folding
      vim.api.nvim_create_user_command(
        "BkbTSToggleFolding",
        function(opts) try_toggle_treesitter_folding() end,
        {
          desc = [[Try to toggle options that enable treesitter folding in the current window if the current buffer has a treesitter parser.

          Note: use `zx` followed by reloading the buffer contents (`:e`) to reset folds.]]
        }
      )
      vim.api.nvim_create_user_command(
        "BkbTSEnableFolding",
        function(opts) try_enable_treesitter_folding() end,
        {
          desc = [[Try to set option to enable treesitter folding in the current window if the current buffer has a treesitter parser. If successfuly, the function will save the current folding options to the buffer vars so that they can be restored when user wants to disable treesitter folding.

          Note: use `zx` followed by reloading the buffer contents (`:e`) to reset folds.]]
        }
      )
      vim.api.nvim_create_user_command(
        "BkbTSDisableFolding",
        function(opts) try_disable_treesitter_folding() end,
        {
          desc = [[Try to revert the folding options to their previous values before enabling treesitter folding in the current window if the current buffer has a treesitter parser.

          Note: use `zx` followed by reloading the buffer contents (`:e`) to reset folds.]]
        }
      )

      -- Try enableing treesitter folding automatically
      vim.api.nvim_create_autocmd(
        {
          "BufWinEnter",
          "FileType"
        },
        {
          desc = "Activate treesitter-based folding in windows that host buffers that have treesitter grammars",
          group = vim.api.nvim_create_augroup("TreesitterFolding", { clear = true }),
          callback = function(ev)
            -- Small delay to ensure neovim initialized buffer properly:
            -- - 'filetype' property is set.
            -- - The buffer is fully loaded.
            -- - Treesitter parser is initialized.
            -- Alternatively, users should run :BkbTSToggleFolding manipulate the treesitter folding
            vim.defer_fn(function() try_enable_treesitter_folding(ev.buf) end, 100)
          end,
        }
      )

      -- Keymappings
      vim.keymap.set(
        "n",
        "<leader><leader>gc",
        function() require("treesitter-context").go_to_context(vim.v.count1) end,
        { silent = true }
      )
    end,
  }
)

---- nvim-lspconfig
    -- TODO: configurer keybidning to force reload all LSPs + force reload LSPs related to the current buffer
    -- :lua vim.lsp.stop_client(vim.lsp.get_clients())
    -- :edit

local nvim_lspconfig_lazy_spec = bpu:declare_lazy_spec(
  "config.infra.plugins.nvim-lspconfig",
  {
    config = function(lazy_plugin, opts)
      -- TODO: configurer
      -- TODO: configurer LSPs servers in a separate directory
    end
  }
)

---- telescope
-- local telescope_spec = bpu:declare_lazy_spec(
--   -- TODO
--   "config.infra.plugins.telescope",
--   {
--     -- TODO: link to config
--     opts = {
--       -- TODO
--     },
--   }
-- )

--- Initialize lazy.nvim plugin manager
local lazy_plugin_infra = require("config.infra.lazy")
lazy_plugin_infra.init()
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
    notify = false,
  },
})
