local M = {}

local Set = require("bkblib.utils.set")

M.SUPPORTED_LSP_SERVERS = Set.mk({
  "lua_ls",
  "clangd",
  "rust_analyzer",
  "gopls",
  "basedpyright",
  "ruff",
  "marksman",
  "sqls",
})

local function configure_supported_lsp_servers()
  -- LuaLS
  --- The lua_ls configuration comes from `:help lspconfig-all` lua_ls section
  -- https://luals.github.io/wiki/settings/
  vim.lsp.config("lua_ls", {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath("config") and (vim.uv.fs_stat(path.."/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
          return nil
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you"re using
          -- (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT"
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            -- Depending on the usage, you might want to add additional paths here.
            "${3rd}/luv/library",
            -- "${3rd}/busted/library",
          }
          -- or pull in all of "runtimepath". NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {
        format = {
          enable = true,
          defaultConfig = {
            indent_style = "space",
            indent_size = 2,
            quote_style = "double",
            call_arg_parentheses = "keep",
            continuation_indent = 4,
            max_line_length = 120,
            trailing_table_separator = "always",
            insert_final_newline = true,
            space_around_table_field_list = false,
            space_before_function_open_parenthesis = false,
            space_before_function_call_open_parenthesis = false,
            space_before_closure_open_parenthesis = false,
            space_before_function_call_single_arg = false,
            space_before_open_square_bracket = false,
            space_inside_function_call_parentheses = false,
            space_inside_function_param_list_parentheses = false,
            space_inside_square_brackets = false,
            space_around_table_append_operator = true,
            ignore_spaces_inside_function_call = false,
            space_before_inline_comment = true,
            space_around_math_operator = true,
            space_after_comma = true,
            space_after_comma_in_for_statement = true,
            space_around_concat_operator = false,
            align_call_args = false,
            align_function_params = false,
            align_continuous_assign_statement = false,
            align_continuous_rect_table_field = false,
            align_if_branch = false,
            align_array_table = false,
            never_indent_before_if_condition = false,
            never_indent_comment_on_if_branch = false,
            line_space_after_if_statement = "keep",
            line_space_after_do_statement = "keep",
            line_space_after_while_statement = "keep",
            line_space_after_repeat_statement = "keep",
            line_space_after_for_statement = "keep",
            line_space_after_local_or_assign_statement = "keep",
            line_space_after_function_statement = "fixed(2)",
            line_space_after_expression_statement = "keep",
            line_space_after_comment = "keep",
            break_all_list_when_line_exceed = false,
            auto_collapse_lines = false,
            ignore_space_after_colon = false,
            remove_call_expression_list_finish_comma = false,
            end_statement_with_semicolon = "same_line",
          },
        },
        completion = {
          enable = true,
        },
        diagnostics = {
          enable = true,
        },
        codeLens = {
          enable = true,
        },
        hint = {
          enable = true,
          paramName = "All",
          paramType = true,
        },
        hover = {
          enable = true,
        },
        semantic = {
          enable = true,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })

  -- clangd
  --- The clangd configuration comes from `:help lspconfig-all` clangd section
  vim.lsp.config("clangd", {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = {
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac", -- AutoTools
      ".git",
    },
    settings = {},
  })

  -- rust-analyzer
  --- https://rust-analyzer.github.io/book/configuration.html
  vim.lsp.config("rust_analyzer", {
    settings = {
      ['rust-analyzer'] = {
        assist = {
          expressionFillDefault = "TODO",
          termSearch = {
            borrowcheck = true,
          },
        },
        cachePriming = {
          enable = true,
        },
        cargo = {
          allTargets = true,
          autoreload = true,
          buildScripts = {
            enable = true,
            rebuildOnSave = true,
            useRustcWrapper = true,
          },
          noDefaultFeatures = false,
          noDeps = false,
        },
        cfg = {
          setTest = true,
        },
        checkOnSave = true,
        check = {
          workspace = true,
        },
        completion = {
          addSemicolonToUnit = true,
          autoAwait = {
            enable = true,
          },
          autoIter = {
            enable = true,
          },
          autoimport = {
            enable = true,
          },
          autoself = {
            enable = true,
          },
          fullFunctionSignatures = {
            enable = true,
          },
          hideDeprecated = false,
          postfix = {
            enable = true,
          },
          privateEditable = {
            enable = false,
          },
          termSearch = {
            enable = false,
          },
        },
        diagnostics = {
          enable = true,
          experimental = {
            enable = false,
          },
          styleLints = {
            enable = true,
          },
        },
        highlightRelated = {
          breakPoints = {
            enable = true,
          },
          closureCaptures = {
            enable = true,
          },
          exitPoints = {
            enable = true,
          },
          references = {
            enable = true,
          },
          yieldPoints = {
            enable = true,
          },
        },
        hover = {
          actions = {
            debug = {
              enable = true,
            },
            enable = true,
            gotoTypeDef = {
              enable = true,
            },
            implementations = {
              enable = true,
            },
            references = {
              enable = true,
            },
            run = {
              enable = true,
            },
            updateTest = {
              enable = true,
            },
          },
          documentation = {
            enable = true,
            keywords = {
              enable = true,
            },
          },
          dropGlue = {
            enable = true,
          },
          links = {
            enable = true,
          },
          memoryLayout = {
            enable = true,
            niches = false,
          },
        },
        imports = {
          granularity = {
            enforce = false,
          },
          group = {
            enable = true,
          },
          merge = {
            glob = true,
          },
          preferNoStd = false,
          preferPrelude = false,
          prefixExternPrelude = false,
        },
        inlayHints = {
          bindingModeHints = {
            enable = false,
          },
          chainingHints = {
            enable = true,
          },
          closingBraceHints = {
            enable = true,
          },
          closureCaptureHints = {
            enable = false,
          },
          expressionAdjustmentHints = {
            hideOutsideUnsafe = false,
          },
          genericParameterHints = {
            const = {
              enable = true,
            },
            lifetime = {
              enable = false,
            },
            type = {
              enable = false,
            },
          },
          implicitDrops = {
            enable = false,
          },
          implicitSizedBoundHints = {
            enable = false,
          },
          lifetimeElisionHints = {
            enable = "never",
            useParameterNames = false,
          },
          parameterHints = {
            enable = true,
          },
          rangeExclusiveHints = {
            enable = false,
          },
          renderColons = true,
          typeHints = {
            enable = true,
            hideClosureInitialization = false,
            hideClosureParameter = false,
            hideNamedConstructor = false,
          },
        },
        interpret = {
          tests = false,
        },

        joinLines = {
          joinAssignments = true,
          joinElseIf = true,
          removeTrailingComma = true,
          unwrapTrivialBlock = true,
        },
        lens = {
          enable = true,
          debug = {
            enable = true,
          },
          implementations = {
            enable = true,
          },
          location = "above_name",
          references = {
            adt = {
              enable = false,
            },
            enumVariant = {
              enable = false,
            },
            method = {
              enable = false,
            },
            trait = {
              enable = false ,
            },
          },
          run = {
            enable = true,
          },
          updateTest = {
            enable = true,
          },
        },
        notifications = {
          cargoTomlNotFound = true,
        },
        procMacro = {
          enable = true,
          attributes = {
            enable = true,
          },
        },
        references = {
          excludeImports = false,
          excludeTests = false,
        },
        rustfmt = {
          rangeFormatting = {
            enable = false,
          },
        },
        semanticHighlighting = {
          doc = {
            comment = {
              inject = {
                enable = true,
              },
            },
          },
          nonStandardTokens = true,
          operator = {
            enable = true,
            specialization = {
              enable = false,
            },
          },
          punctuation = {
            enable = false,
            separate = {
              macro = {
                bang = false
                ,  },
            },
            specialization = {
              enable = false,
            },
          },
          strings = {
            enable = true,
          },
        },
        signatureInfo = {
          detail = "full",
          documentation = {
            enable = true,
          },
        },
      },
      workspace = {
        symbol = {
          search = {
            scope = "workspace",
          },
        },
      },
    },
  })

  -- gopls
  --- Settings are taken from https://github.com/golang/tools/blob/master/gopls/doc/settings.md
  vim.lsp.config("gopls", {
    settings = {
      gopls = {
        codelenses = {
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = false,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        semanticTokens = false,
        usePlaceholders = false,
        matcher = "Fuzzy",
        experimentalPostfixCompletions = false,
        completeFunctionCalls = true,
        staticcheck = false,
        vulncheck = "off",
        analysisProgressReporting = true,
        hoverKind = "FullDocumentation",
        linkTarget = "godoc.org",
        linksInHover = true,
        importShortcut = "Both",
        symbolMatcher = "FastFuzzy",
        symbolStyle = "Dynamic",
        symbolScope = "all",
        verboseOutput = false,
        gofumpt = true,
      },
    },
  })

  -- basedpyright
  --- https://docs.basedpyright.com/dev/configuration/language-server-settings/
  vim.lsp.config("basedpyright", {
    settings = {
      basedpyright = {
        disableOrganizeImports = true, -- use ruff to organize imports
        analysis = {
          autoImportCompletions = true,
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          useLibraryCodeForTypes = true,
          useTypingExtensions = true,
          fileEnumerationTimeout = 10,
          inlayHints = {
            variableTypes = true,
            callArgumentNames = true,
            functionReturnTypes = true,
            genericTypes = true,
          },
        },
      },
    },
  })

  -- ruff
  --- https://docs.astral.sh/ruff/editors/settings/
  vim.lsp.config("ruff", {
    on_init = function(client, _)
      client.server_capabilities.hoverProvider = false
    end,
    init_options = {
      configuration = {
        lint = {
          fixable = { "ALL" },
          select = { "ALL" },
        },
        format = {
          ["quote-style"] = "double",
          ["indent-style"] = "space",
          ["skip-magic-trailing-comma"] = false,
          ["line-ending"] = "auto",
        },
      },
    },
    settings = {
      lineLength = 120,
      configurationPreference = "filesystemFirst",
      fixAll = true,
      organizeImports = true,
      showSyntaxErrors = true,
      codeAction = {
        disableRuleComment = {
          enable = true,
        },
        fixViolation = {
          enable = false,
        },
      },
      lint = {
        enable = true,
        preview = false,
        select = { "ALL" },
      },
      format = {
        preview = false,
      },
    },
  })

  -- marksman
  --- https://github.com/artempyanykh/marksman/blob/main/docs/configuration.md
  vim.lsp.config("marksman", {
    settings = {
      core = {
        markdown = {
          glfm_heading_ids = {
            enable = true,
          },
        },
        text_sync = "full",
        title_from_heading = false,
        incremental_references = false,
        paranoid = false,
      },
      code_action = {
        toc = {
          enable = true,
        },
        create_missing_file = {
          enable = true,
        },
      },
      completion = {
        candidates = 50,
        wiki = {
          style = "title-slug",
        },
      },
    },
  })

  -- sqls
  --- https://github.com/sqls-server/sqls
  vim.lsp.config("sqls", {
    settings = {},
  })
end

local function register_custom_on_attach()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("bkb-lsp-attach", { clear = true }),
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

      -- Enable inlay hints if LSP server supports them
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
      end
    end
  })
end

local function enable_suppored_lsp_servers()
  for lsp_server in M.SUPPORTED_LSP_SERVERS:pairs() do
    vim.lsp.enable(lsp_server)
  end
end

function M.bkb_setup_suppotred_lsp_servers()
  configure_supported_lsp_servers()
  register_custom_on_attach()
  enable_suppored_lsp_servers()
end

return M
