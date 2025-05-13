local M = {}

local Set = require("bkblib.utils.set")

M.SUPPORTED_LSP_SERVERS = Set.mk({
  "lua_ls",
})

local function configure_supported_lsp_servers()
  -- LuaLS
  --- The lua_ls configuratio comes from `:help lspconfig-all` lua_ls section
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
        }
      }
    }
  })
end

local function enable_suppored_lsp_servers()
  for lsp_server in M.SUPPORTED_LSP_SERVERS:pairs() do
    vim.lsp.enable(lsp_server)
  end
end

function M.bkb_setup_suppotred_lsp_servers()
  configure_supported_lsp_servers()
  enable_suppored_lsp_servers()
end

return M
