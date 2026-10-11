resource "google_gemini_code_tools_setting" "gemini_code_tools_settings" {
  for_each = var.gemini_code_tools_settings

  code_tools_setting_id = each.value.code_tools_setting_id
  deletion_policy       = each.value.deletion_policy
  labels                = each.value.labels
  location              = each.value.location
  project               = each.value.project

  dynamic "enabled_tool" {
    for_each = each.value.enabled_tool
    content {
      account_connector = enabled_tool.value.account_connector
      dynamic "config" {
        for_each = enabled_tool.value.config != null ? enabled_tool.value.config : []
        content {
          key   = config.value.key
          value = config.value.value
        }
      }
      handle       = enabled_tool.value.handle
      tool         = enabled_tool.value.tool
      uri_override = enabled_tool.value.uri_override
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

