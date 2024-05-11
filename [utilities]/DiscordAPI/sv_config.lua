Config = {
    DiscordToken = "MTIwODUyMjc5NjY0MTE2MTMzNg.Gs_QBl.hKvylLQ0RTS2P6ZcIfO3myWOpKG6hJdEphPkR8", -- Bot token (The bot must be in your Discord server.)
    GuildID = "1179485103106314321", -- Server ID (The server that the roles are based off of.)

    ChatRolesEnabled = true, -- If you'd like chat tags, staff chat, enabled or not.
    RoleList = { -- Role ID of 0, will grant the role to everyone.
        {0, "👦🏻 ^4Civilian | "}, -- All.
        {1210349006194999328, "TESTER"}, -- Tester
        {1203867636346396772, "DEV"},
        {1182031965243846686, "OWNER"}
    },
    ServerID = true, -- If you'd like the resource to disable the players server ID before their name in chat.

    DiscordRoles = { -- Roles you'd like to be able to check for using the Discord API. Name is anything you'd like it to be.
        [ "TESTER" ] = "1210349006194999328",
        [ "OWNER" ] = "1182031965243846686",
        [ "DEV" ] = "1203867636346396772",
    },

    AcePermsEnabled = true, -- If you'd like the resource to grant ace permissions or not.
    Groups = { -- These are the group ace permissions that you'd like to grant based off of Discord roles.
        [ "1210349006194999328" ] = "group.admin", --// Role: Owner
        [ "1182031965243846686" ] = "group.god", --//DiscOwner
        [ "1203867636346396772" ] = "group.god", --//UltimateDEV
        [ "793043765224931388" ] = "group.member", --// Role: Member
    },
    Permissions = { -- Special command permissions you'd like to grant users with certain Discord roles.
        [ "1210349006194999328" ] = { --// Role: Owner
            "aop.*",
            "chattoggle",
        },
        [ "1182031965243846686" ] = { --// Role: Owner
            "aop.*",
            "chattoggle",
        },
        [ "1203867636346396772" ] = { --// Role: Owner
            "aop.*",
            "chattoggle",
        }
    }
}