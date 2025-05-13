local M = {}

---@return nil
function M.add_bkb_filetypes()
    -- Note on compound/composite filetypes:
    -- Some (n)vim configs, docs, and plugins might refer to a concept known as coumpound or composite filetype.
    -- Such filetypes have dot in their name. This concept is not documented formally, but rather, it is a
    -- convention in (n)vim community.
    --
    -- There is some level of support for this concept in neovim. Examples worth mentioning:
    -- - `:help vim.treesitter.language.get_lang()` - mentions that if no language has been
    --     `vim.treesitter.language.register()`-ed for a filetype and if it is a composite filetype, nvim should select
    --     only the treesitter language that matches the "main" filetype. In practice, the behavior is such
    --     that for composite filetypes nvim selects the same treesitter parser as if the name before the . was used
    --     as a filetype. I.e. for `html.glimmer`, nvim would select the `html` treesitter grammar, e.g. try:
    --     `:=vim.treesitter.language.get_lang("html.glimmer")`

  vim.filetype.add({
    pattern = {
      -- Set the yaml.docker-compose filetype for compose files (https://github.com/compose-spec/compose-spec) so that the default lsp-config (https://github.com/neovim/nvim-lspconfig) will run the compose LSP (https://www.npmjs.com/package/@microsoft/compose-language-service)
      ["compose%..*%.ya?ml"] = { "yaml.docker-compose", { priority = 0 } },
      ["compose.ya?ml"] = { "yaml.docker-compose", { priority = 0 } },

      -- Recongnize files that end in .?Containerfile as dockerfile
      [".*%.?Containerfile"] = { "dockerfile", { priority = 0 } },
      ["Containerfile"] = { "dockerfile", { priority = 0 } },

      -- .bazelrc
      [".*.bazelrc"] = "bazelrc",
    }
  })
end

return M
