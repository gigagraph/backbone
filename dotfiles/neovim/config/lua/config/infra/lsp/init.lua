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
  "bashls",
  "texlab",
  "docker_compose_language_service",
  "dockerls",
  -- Enable jdtls by default and disable java_language_server. FileType event for java will enable keybindings to switch LSPs.
  -- "java_language_server",
  "jdtls",
  "buf_ls",
  "yamlls",
  "helm_ls",
  "bazelrc_lsp",
  "starpls",
  "cue",
  -- haskell-tools.nvim plugin will enable hls LSP when needed
  -- "hls",
  "nixd",
  "emmet_language_server",
  "html",
  "jsonls",
  "cssls",
  "css_variables",
  "somesass_ls",
  "stylelint_lsp",
  "tailwindcss",
  -- TODO: rest
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

  -- bashls
  --- https://github.com/bash-lsp/bash-language-server/blob/main/server/src/config.ts
  vim.lsp.config("bashls", {
    settings = {
      bashIde = {
        backgroundAnalysisMaxFiles = 500,
        enableSourceErrorDiagnostics = true,
        explainshellEndpoint = "",
        includeAllWorkspaceSymbols = false,
        shfmt = {
          languageDialect = "auto",
          binaryNextLine = false,
          caseIndent = true,
          funcNextLine = false,
          simplifyCode = false,
          spaceRedirects = true,
        },
      },
    },
  })

  -- texlab
  --- https://github.com/latex-lsp/texlab/wiki/Configuration
  vim.lsp.config("texlab", {
    settings = {
      texlab = {
        build = {
          args = {
            "-pdf",
            "-interaction=nonstopmode",
            "-synctex=1",
            "-auxdir=./latex-build",
            "-outdir=./latex-build",
            "%f"
          },
          executable = "latexmk",
          forwardSearchAfter = false,
          onSave = false,
          useFileList = false,
          -- Note, users must set the -auxdir=./latex-build in texlab.build.args
          auxFirectory = "./latex-build",
          -- Note, users must set the -outdir=./latex-build in texlab.build.args
          logDirectory = "./latex-build",
          -- Note, users must set the -outdir=./latex-build in texlab.build.args
          pdfDirectory = "./latex-build",
        },
        chktex = {
          onOpenAndSave = true,
          onEdit = true,
          additionalArgs = {
            "--warnon",
            "--erroron",
            "--msgon",
          },
        },
        diagnosticsDelay = 300,
        formatterLineLength = 120,
        bibtexFormatter = "texlab",
        latexFormatter = "texlab",
        completion = {
          matcher = "fuzzy-ignore-case",
        },
        inlayHints = {
          labelDefinitions = true,
          labelReferences = true,
          maxLength = nil,
        },
        experimental = {
          followPackageLinks = false,
          mathEnvironments = {},
          enumEnvironments = {},
          verbatimEnvironments = {},
          citationCommands = {},
          labelDefinitionCommands = {},
          labelReferenceCommands = {},
          labelReferenceRangeCommands = {},
          labelDefinitionPrefixes = {},
          labelReferencePrefixes = {},
        },
      },
    },
  })

  -- docker_compose_language_service
  vim.lsp.config("docker_compose_language_service", {
    settings = {
      -- This LSP does not take settings
    },
  })

  -- dockerls
  --- https://github.com/rcjsuen/dockerfile-language-server#language-server-settings
  vim.lsp.config("dockerls", {
    settings = {
      docker = {
        languageserver = {
          diagnostics = {
            deprecatedMaintainer = "warning",
            directiveCasing = "warning",
            emptyContinuationLine = "warning",
            instructionCasing = "warning",
            instructionCmdMultiple = "warning",
            instructionEntrypointMultiple = "warning",
            instructionHealthcheckMultiple = "warning",
            instructionJSONInSingleQuotes = "warning",
          },
          formatter = {
            ignoreMultilineInstructions = true,
          },
        },
      },
    },
  })

  -- Java
  --- jdtls
  ---- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  local jdtls_settings = {
    java = {
      autobuild = {
        enabled = false,
      },
      cleanup = {
        actionsOnSave = {
          "qualifyMembers",
          "qualifyStaticMembers",
          "addOverride",
          "addDeprecated",
          "stringConcatToTextBlock",
          "invertEquals",
          "addFinalModifier",
          "instanceofPatternMatch",
          "lambdaExpression",
          "switchExpression",
        },
      },
      codeAction = {
        sortMembers = {
          avoidVolatileChanges = true,
        }
      },
      completion = {
        enabled = true,
        matchCase = false,
        maxResults = 50,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      contentProvider = {
        preferred = nil,
      },
      eclipse = {
        downloadSources = true,
      },
      errors = {
        incompleteClasspath = {
          severity = "warning",
        }
      },
      executeCommand = {
        enabled = false,
      },
      foldingRange = {
        enabled = false,
      },
      format = {
        enabled = true,
        comments = {
          enabled = true,
        },
        insertSpaces = true,
        onType = {
          enabled = true,
        },
        tabSize = 2,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      import = {
        gradle = {
          enabled = true,
        },
        maven = {
          enabled = true,
        },
      },
      inlayhints = {
        parameterNames = {
          enabled = "literals",
        },
      },
      jdt = {
        ls = {
          androidSupport = {
            enabled = true,
          },
          lombokSupport = {
            enabled = true,
          },
          protofBufSupport = {
            enabled = true,
          },
        },
      },
      maven = {
        downloadSources = true,
        updateSnapshots = false,
      },
      project = {
        encoding = "WARNING",
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeAccessors = true,
        includeDecompiledSources = true,
      },
      rename = {
        enabled = true,
      },
      saveActions = {
        organizeImports = true,
      },
      selectionRange = {
        enabled = true,
      },
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
      symbols = {
        includeSourceMethodDeclarations = true,
      },
      trace = {
        server = "off",
      },
      edit = {
        validateAllOpenBuffersOnChanges = true,
      },
    }
  }
  vim.lsp.config("jdtls", {
    -- Note, because this setup uses nvim-jdtls which requires the config to specify cmd when calling start_or_attach and since cmd for jdtls depends on the project being opened, cmd is calcualted and specified in autocmds below
    settings = jdtls_settings,
  })

  --- java_language_server
  vim.lsp.config("java_language_server", {
    cmd = { "java-language-server" },
    settings = {
      -- This LSP does not take settings
    },
  })

  local jdtls_cmd = nil
  local jdtls_data_path = nil
  vim.api.nvim_create_autocmd(
    { "FileType" },
    {
      desc = "Setup keymappings to control Java LSPs.",
      pattern = { "java", "java.*" },
      group = vim.api.nvim_create_augroup("bkb-java-lsp-kemappings", { clear = true }),
      once = true,
      callback = function(_)
        if not jdtls_data_path then
          local path = require("plenary.path")

          local cwd_last_component = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
          jdtls_data_path = vim.fn.resolve(
            tostring(
              path.new(vim.fn.stdpath("cache"))
                :joinpath("bkb/lsp_cache/jdtls")
                :joinpath(cwd_last_component)
            )
          )
        end

        jdtls_cmd = {
          "jdtls",
          "-data", jdtls_data_path
        }

        -- Enable and start LSP
        -- By default, enable jdtls and start/attach to it and ensure that java-language-server is disabled
        vim.lsp.enable("java-language-server", false)
        require("jdtls").start_or_attach({
          cmd = jdtls_cmd,
          settings = jdtls_settings
        })

        vim.keymap.set(
          "n",
          "<leader><leader>ljj1",
          function()
            vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = 0 }))
            -- Ensure to first disable then enable. Order matters.
            vim.lsp.enable("java_language_server", false)
            require("jdtls").start_or_attach({
              cmd = jdtls_cmd,
              settings = jdtls_settings
            })
            vim.lsp.enable("jdtls", true)
            vim.cmd.edit()
          end,
          {
            silent = true,
            desc = "Switch to jdtls LSP for a java project."
          }
        )
        vim.keymap.set(
          "n",
          "<leader><leader>ljj2",
          function()
            vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = 0 }))
            -- Ensure to first disable then enable. Order matters.
            vim.lsp.enable("jdtls", false)
            vim.lsp.enable("java_language_server", true)
            vim.cmd.edit()
          end,
          {
            silent = true,
            desc = "Switch to java_language_server LSP for a java project."
          }
        )
        vim.keymap.set(
          "n",
          "<leader><leader>ljjc",
          function()
            vim.ui.input({
              prompt = "Remove the jdtls data directory (" .. jdtls_data_path .. ")? (`y` to confirm): ",
            },
              function(input)
                if input == "y" then
                  vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = 0 }))
                  vim.system(
                    { "rm", "-rf", jdtls_data_path },
                    { text = true }
                  ):wait()
                  vim.cmd.edit()
                end
              end
            )
          end,
          {
            silent = true,
            desc = "Clean up jdtls data dir for the project."
          }
        )
      end,
    }
  )

  vim.api.nvim_create_autocmd(
    { "FileType" },
    {
      desc = "Start jdtls.",
      pattern = { "java", "java.*" },
      group = vim.api.nvim_create_augroup("bkb-jdtls-init", { clear = true }),
      callback = function(_)
        if vim.lsp.is_enabled("jdtls") then
          -- Note, since nvim guarantees that autocmds are executed in the same oreder in which they were registered, jdtls_cmd will be set by the previously registered autocmd.
          require("jdtls").start_or_attach({ cmd = jdtls_cmd })
        end
      end,
    }
  )

  -- buf_ls
  vim.lsp.config("buf_ls", {
    settings = {
      -- This LSP does not take settings
    },
  })

  -- yamlls
  --- https://github.com/redhat-developer/yaml-language-server#language-server-settings
  vim.lsp.config("yamlls", {
    settings = {
      yaml = {
        yamlVersion = "1.2",
        format = {
          enable = true,
          singleQuote = false,
          bracketSpacing = false,
          proseWrap = "Preserve",
          printWidth = 120,
        },
        validate = true,
        completion = true,
        schemas = {},
        schemaStore = {
          enable = false,
        },
        editor = {
          formatOnType = true,
        },
        disableDefaultProperties = false,
        suggest = {
          parentSkeletonSelectedFirst = false,
        },
        keyOrdering  = false,
      },
      redhat = {
        telemetry = {
          enabled = false,
        },
      },
    },
  })

  -- helm_ls
  --- https://github.com/mrjosh/helm-ls/tree/master#configuration-options
  vim.lsp.config("helm_ls", {
    settings = {
      ["helm-ls"] = {
        logLevel = "info",
        valuesFiles = {
          mainValuesFile = "values.yaml",
          lintOverlayValuesFile = "values.lint.yaml",
          additionalValuesFilesGlobPattern = "values*.yaml"
        },
        helmLint = {
          enabled = true,
          ignoredMessages = {},
        },
        yamlls = {
          enabled = true,
          enabledForFilesGlob = "*.{yaml,yml}",
          diagnosticsLimit = 50,
          showDiagnosticsDirectly = false,
          path = "yaml-language-server",
          initTimeoutSeconds = 3,
          config = {
            schemas = {
              kubernetes = "templates/**",
            },
            completion = true,
            hover = true,
            -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
          }
        }
      },
    }
  })

  -- bazelrc_lsp
  vim.lsp.config("bazelrc_lsp", {
    settings = {
      -- This LSP does not take settings
    },
  })

  -- starpls
  vim.lsp.config("starpls", {
    settings = {
      -- This LSP does not take settings
    },
  })

  -- cue
  vim.lsp.config("cue", {
    settings = {
      -- This LSP does not take settings
    },
  })

  -- hls
  -- Note: since this setup uses haskell-tools.nvim that configures hls, the hls settings reside where this config initializes the plugin.
  -- vim.lsp.config("hls", {})

  -- nixd
  --- https://github.com/nix-community/nixd/blob/main/nixd/docs/configuration.md
  vim.lsp.config("nixd", {
    cmd = {
      "nixd",
      "--inlay-hints=true",
      "--semantic-tokens=true",
    },
    settings = {
      nixd = {
        nixpkgs = {
          expr = "import <nixpkgs> { }",
        },
         formatting = {
            command = { "nixfmt" },
         },
      },
   },
  })

  -- emmet-language-server
  --- https://github.com/olrtg/emmet-language-server#neovim
  vim.lsp.config("emmet_language_server", {
    init_options = {
      preferences = {
        -- https://docs.emmet.io/customization/preferences/
        bem = {
          elementSeparator = "__",
          modifierSeparator = "_",
          shortElementPrefix = "-",
        },
        caniuse = {
          enabled = true,
          era = "e-2",
          vendors = "all",
        },
        css = {
          alignVendor = false,
          autoInsertVendorPrefixes = false,
          closeBraceIndentation = "",
          color = {
            case = "keep",
            short = false,
          },
          floatUnit = "em",
          fuzzySearch = true,
          fuzzySearchMinScore = 0.3,
          gradient = {
            defaultProperty = "background-image",
            fallback = false,
            oldWebkit = false,
          },
          intUnit = "px",
          propertyEnd = ";",
          syntaxes = {
                "css",
                "less",
                "sass",
                "scss",
                "stylus",
                "styl",
          },
          valueSeparator = ": ",
        },
        less = {
          autoInsertVendorPrefixes = false,
        },
        sass = {
          autoInsertVendorPrefixes = false,
        },
        scss = {
          autoInsertVendorPrefixes = false,
        },
        slim = {
          attributesWrapper = "none",
        },
        stylus = {
          autoInsertVendorPrefixes = false,
          valueSeparator = " ",
        },
        lorem = {
          defaultLang = "en",
        },
        omitCommonPart = false,
        profile = {
          allowCompactBoolean = true,
        },
      },
      showAbbreviationSuggestions = true,
      showExpandedAbbreviation = "always",
      showSuggestionsAsSnippets = true,
      syntaxProfiles = {
        -- https://docs.emmet.io/customization/syntax-profiles/
      },
    },
  })

  -- htlm
  --- :help lspconfig-all
  vim.lsp.config("html", {
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true,
      },
      provideFormatter = true,
    },
  })

  -- jsonls
  --- :help lspconfig-all
  vim.lsp.config("jsonls", {
    init_options = {
      provideFormatter = true,
    },
  })

  -- cssls
  --- :help lspconfig-all
  vim.lsp.config("cssls", {
    init_options = {
      provideFormatter = true,
    },
  })

  -- css_variables
  --- https://github.com/vunguyentuan/vscode-css-variables/blob/master/packages/vscode-css-variables/package.json#L38
  vim.lsp.config("css_variables", {
    settings = {},
  })

  -- somesass_ls
  --- https://wkillerud.github.io/some-sass/language-server/settings.html
  vim.lsp.config("somesass_ls", {
    settings = {
      somesass = {
        suggestAllFromOpenDocument = true,
        scss = {
          workspace = {
            logLevel = "info",
          },
          codeAction = {
            enabled = true,
          },
          colors = {
            enabled = true,
            includeFromCurrentDocument = true,
          },
          completion = {
            enabled = true,
            includeFromCurrentDocument = true,
            suggestFromUseOnly = false,
            mixinStyle = "all",
            triggerPropertyValueCompletion = true,
            completePropertyWithSemicolon = true,
          },
          definition = {
            enabled = true,
          },
          diagnostics = {
            enabled = true,
            deprecation = {
              enabled = true,
            },
            lint = {
              enabled = true,
              compatibleVendorPrefixes = true,
              vendorPrefix = true,
              duplicateProperties = true,
              emptyRules = true,
              importStatement = true,
              boxModel = true,
              universalSelector = true,
              zeroUnits = true,
              fontFaceProperties = true,
              hexColorLength = true,
              argumentsInColorFunction = true,
              unknownProperties = true,
              ieHack = true,
              unknownVendorSpecificProperties = true,
              propertyIgnoredDueToDisplay = true,
              important = true,
              float = true,
              idSelector = true,
            },
          },
          documentSymbol = {
            enabled = true,
          },
          foldingRanges = {
            enabled = true,
          },
          highlights = {
            enabled = true,
          },
          hover = {
            enabled = true,
            documentation = true,
          },
          links = {
            enabled = true,
          },
          references = {
            enabled = true,
          },
          rename = {
            enabled = true,
          },
          selectionRanges = {
            enabled = true,
          },
          signatureHelp = {
            enabled = true,
          },
          workspaceSymbol = {
            enabled = true,
          },
        },
        sass = {
          codeAction = {
            enabled = true,
          },
          colors = {
            enabled = true,
          },
          completion = {
            enabled = true,
            suggestFromUseOnly = true,
            mixinStyle = "all",
            triggerPropertyValueCompletion = true,
          },
          definition = {
            enabled = true,
          },
          diagnostics = {
            enabled = true,
            deprecation = {
              enabled = true,
            },
            lint = {
              enabled = true,
              compatibleVendorPrefixes = true,
              vendorPrefix = true,
              duplicateProperties = true,
              emptyRules = true,
              importStatement = true,
              boxModel = true,
              universalSelector = true,
              zeroUnits = true,
              fontFaceProperties = true,
              hexColorLength = true,
              argumentsInColorFunction = true,
              unknownProperties = true,
              ieHack = true,
              unknownVendorSpecificProperties = true,
              propertyIgnoredDueToDisplay = true,
              important = true,
              float = true,
              idSelector = true,
            },
          },
          foldingRanges = {
            enabled = true,
          },
          highlights = {
            enabled = true,
          },
          hover = {
            enabled = true,
            documentation = true,
            references = true,
          },
          links = {
            enabled = true,
          },
          references = {
            enabled = true,
          },
          rename = {
            enabled = true,
          },
          selectionRanges = {
            enabled = true,
          },
          signatureHelp = {
            enabled = true,
          },
          workspaceSymbol = {
            enabled = true,
          },
        },
        css = {
          codeAction = {
            enabled = true,
          },
          colors = {
            enabled = true,
          },
          completion = {
            enabled = true,
            triggerPropertyValueCompletion = true,
            completePropertyWithSemicolon = true,
          },
          definition = {
            enabled = true,
          },
          diagnostics = {
            enabled = true,
            deprecation = {
              enabled = true,
            },
            lint = {
              enabled = true,
              compatibleVendorPrefixes = true,
              vendorPrefix = true,
              duplicateProperties = true,
              emptyRules = true,
              importStatement = true,
              boxModel = true,
              universalSelector = true,
              zeroUnits = true,
              fontFaceProperties = true,
              hexColorLength = true,
              argumentsInColorFunction = true,
              unknownProperties = true,
              ieHack = true,
              unknownVendorSpecificProperties = true,
              propertyIgnoredDueToDisplay = true,
              important = true,
              float = true,
              idSelector = true,
            },
          },
          foldingRanges = {
            enabled = true,
          },
          highlights = {
            enabled = true,
          },
          hover = {
            enabled = true,
            documentation = true,
            references = true,
          },
          links = {
            enabled = true,
          },
          references = {
            enabled = true,
          },
          rename = {
            enabled = true,
          },
          selectionRanges = {
            enabled = true,
          },
          signatureHelp = {
            enabled = true,
          },
          workspaceSymbol = {
            enabled = true,
          },
        },
      },
      ["some-sass"] = {
        trace = {
          server = "off"
        },
      },
    },
  })

  -- stylelint_lsp
  --- https://github.com/bmatcuk/stylelint-lsp#settings
  vim.lsp.config("stylelint_lsp", {
    settings = {
      stylelintplus = {
        enable = true,
        autoFixOnFormat = false,
        autoFixOnSave = false,
        validateOnSave = true,
        validateOnType = true,
        -- Try discovering the cofnig file automatically based on the opened file
        config = nil,
        configFile = nil,
      },
    },
  })

  -- tailwindcss
  --- https://github.com/tailwindlabs/tailwindcss-intellisense#extension-settings
  vim.lsp.config("tailwindcss", {
    settings = {
      tailwindCSS = {
        includeLanguages = {
          eelixir = "html-eex",
          eruby = "erb",
          htmlangular = "html",
          templ = "html"
        },
        emmetCompletions = true,
        colorDecorators = true,
        showPixelEquivalents = false,
        hovers = true,
        suggestions = true,
        codeActions = true,
        lint = {
          invalidScreen = "error",
          invalidVariant = "error",
          invalidTailwindDirective = "error",
          invalidApply = "error",
          invalidConfigPath = "error",
          cssConflict = "warning",
          recommendedVariantOrder = "warning",
          usedBlocklistedClass = "warning",
        },
        validate = true,
      }
    }
  })

  -- TODO: rest
end

---@param deps { notify: table? }? The function will use notify to display LSP messages that a server may send, if the notify dependency is provided.
local function override_custom_lsp_handlers(deps)
  -- If notify plugin is in the argument, use notify asynchronously display LSP server messages
  if deps and deps.notify then
    -- Taken from https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes
    -- Utility functions shared between progress reports for LSP and DAP
    local client_notifs = {}

    local function get_notif_data(client_id, token)
      if not client_notifs[client_id] then
        client_notifs[client_id] = {}
      end

      if not client_notifs[client_id][token] then
        client_notifs[client_id][token] = {}
      end

      return client_notifs[client_id][token]
    end

    local spinner_frames = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }

    local function update_spinner(client_id, token)
      local notif_data = get_notif_data(client_id, token)

      if notif_data.spinner then
        local new_spinner = (notif_data.spinner + 1) % #spinner_frames
        notif_data.spinner = new_spinner

        notif_data.notification = vim.notify(nil, nil, {
          hide_from_history = true,
          icon = spinner_frames[new_spinner],
          replace = notif_data.notification,
        })

        vim.defer_fn(function()
          update_spinner(client_id, token)
        end, 100)
      end
    end

    local function format_title(title, client_name)
      return client_name .. (#title > 0 and ": " .. title or "")
    end

    local function format_message(message, percentage)
      return (percentage and percentage .. "%\t" or "") .. (message or "")
    end

    -- LSP integration
    --- Progress
    vim.lsp.handlers["$/progress"] = function(_, result, ctx)
      local client_id = ctx.client_id

      local val = result.value

      if not val.kind then
        return
      end

      local notif_data = get_notif_data(client_id, result.token)

      if val.kind == "begin" then
        local message = format_message(val.message, val.percentage)

        notif_data.notification = vim.notify(message, vim.log.levels.INFO, {
          title = format_title(val.title, vim.lsp.get_client_by_id(client_id).name),
          icon = spinner_frames[1],
          timeout = false,
          hide_from_history = false,
        })

        notif_data.spinner = 1
        update_spinner(client_id, result.token)
      elseif val.kind == "report" and notif_data then
        notif_data.notification = vim.notify(format_message(val.message, val.percentage), vim.log.levels.INFO, {
          replace = notif_data.notification,
          hide_from_history = false,
        })
      elseif val.kind == "end" and notif_data then
        notif_data.notification =
            vim.notify(val.message and format_message(val.message) or "Complete", vim.log.levels.INFO, {
              icon = "",
              replace = notif_data.notification,
              timeout = 3000,
            })

        notif_data.spinner = nil
      end
    end

    --- Display LSP server messages
    -- table from lsp severity to vim severity.
    local severity = {
      "error",
      "warn",
      "info",
      "info", -- map both hint and info to info
    }
    vim.lsp.handlers["window/showMessage"] = function(err, method, params, client_id)
      vim.notify(method.message, severity[params.type])
    end
  end
end

---@param deps { blink_cmp: table? }? The function will use blink.cmp to add additional LSP capabilities that blink.cmp provides
local function override_lsp_capabilities(deps)
  if deps and deps.blink_cmp then
    vim.lsp.config("*", {
      capabilities = deps.blink_cmp.get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    })
  end
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

      -- Explicitly set formatexpr if LSP server supports fomatting. Sometimes nvim does not automatically set it even when the LSP server supports it.
      if client.server_capabilities.documentFormattingProvider then
        vim.opt_local.formatexpr = "v:lua.vim.lsp.formatexpr()"
      end
    end
  })
end

local function enable_suppored_lsp_servers()
  for lsp_server in M.SUPPORTED_LSP_SERVERS:pairs() do
    vim.lsp.enable(lsp_server)
  end
end

---@param deps { notify: table?, blink_cmp: table? }? Dependnecies the module may use to initialize LSP
function M.bkb_setup_suppotred_lsp_servers(deps)
  deps = deps or {}
  override_custom_lsp_handlers(deps)
  override_lsp_capabilities(deps)
  configure_supported_lsp_servers()
  register_custom_on_attach()
  enable_suppored_lsp_servers()
end

return M
