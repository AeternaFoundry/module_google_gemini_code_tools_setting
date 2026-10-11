variable "gemini_code_tools_settings" {
  description = <<EOT
Map of gemini_code_tools_settings, attributes below
Required:
    - code_tools_setting_id
    - enabled_tool (block):
        - account_connector (optional)
        - config (optional, block):
            - key (required)
            - value (required)
        - handle (required)
        - tool (required)
        - uri_override (optional)
Optional:
    - deletion_policy
    - labels
    - location
    - project
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    code_tools_setting_id = string
    deletion_policy       = optional(string)
    labels                = optional(map(string))
    location              = optional(string)
    project               = optional(string)
    enabled_tool = list(object({
      account_connector = optional(string)
      config = optional(list(object({
        key   = string
        value = string
      })))
      handle       = string
      tool         = string
      uri_override = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.gemini_code_tools_settings : (
        length(v.enabled_tool) >= 1
      )
    ])
    error_message = "Each enabled_tool list must contain at least 1 items"
  }
}

