-- Configuration settings for the GPS system.
Config              = {}

-- Debug print setting for displaying debug messages.
Config.DebugPrint   = true

-- Locale setting for language localization.
Config.Locale       = "en"

-- Open panel command string
Config.PanelCommand = "jobcreator"

Config.Default      = {
    --- ("qb_notify" | "ox_notify" | "okok_notify" | "custom_notify") System to be used
    NotifyType = "qb_notify",
    ---("qb_inventory" | "ox_inventory" | "custom") System to be used
    InventoryType = "qb_inventory",
    ---("qb_target" | "ox_target") System to be used
    TargetType = "qb_target",
    ---("qb_menu" | "ox_menu") System to be used
    MenuType = "qb_menu",
    ---("qb_textui" | "ox_textui" | "draw_text_marker") System to be used
    TextUI_Type = "qb_textui",
    ---("qb_progressbar" | "ox_progressbar_1" | "custom_progressbar") System to be used
    ProgressBarType = "qb_progressbar"
}
