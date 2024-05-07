QBCore.Commands.Add(Config.PanelCommand, "Create new job (Admin Only)", {}, false, function(source)
    TriggerClientEvent("0r-jobcreator:Client:OpenJobCreatorPanel", source)
end, "admin")
