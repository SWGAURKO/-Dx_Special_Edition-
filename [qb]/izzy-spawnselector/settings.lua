Settings = {
    -- here
    botToken = "MTE5NzQ4NTIyMTg3Mjk0MzExNA.G76pzU.tuhemsFiWOyrtybZP0nQhdE7r9KY0rI36PLjh0" -- set your discord bot token, if you dont know you can get help on our discord.
}

Citizen.CreateThread(function()
    -- not here
    while true do
        if Settings["botToken"] == "" then
            print("Please check izzy-spawnselector/settings.lua")
        end
        Citizen.Wait(3000)
    end
end)