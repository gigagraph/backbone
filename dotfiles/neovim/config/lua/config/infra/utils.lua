local BackbonePluginUtils = {}

BackbonePluginUtils.final_lazy_spec = {}

---@param plugin_module string
---@param setup_override table
---@return table
function BackbonePluginUtils:declare_lazy_spec(plugin_module, setup_override)
  local base_lazy_plugin_spec = require(plugin_module)
  local final_lazy_plugin_spec = vim.tbl_deep_extend(
    "force",
    base_lazy_plugin_spec,
    setup_override
  )

  table.insert(self.final_lazy_spec, final_lazy_plugin_spec)

  return final_lazy_plugin_spec
end

return BackbonePluginUtils
