local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('chat:ooc', function(id, name, message, time)
    local id1 = PlayerId()
    local id2 = GetPlayerFromServerId(id) 
    if id2 == id1 then
        TriggerEvent('chat:addMessage', {
			template = '<div style="position: relative;" class="chat-message ooc"><b><span style="position: absolute; top: 1vh; font-size: 16px; color: #fff; padding-bottom: 2px; border-bottom: 2px solid #0084ff; transform: rotate(-90deg); ">OOC</span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {1}</span>&nbsp;<span style="position: relative; left: 3vh; font-size: 12px; color: #fff; padding-top: 2px; padding-left: 5px; padding-right: 5px; padding-bottom: 2px; border: 2px solid #7d7d7d; background: #555555c0; border-radius: 5px;">{0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{3}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{2}</div></div>',
			args = { id, name, message, time }
		})
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id1)), GetEntityCoords(GetPlayerPed(id2)), true) < Config.OOCDistance then
        TriggerEvent('chat:addMessage', {
			template = '<div style="position: relative;" class="chat-message ooc"><b><span style="position: absolute; top: 1vh; font-size: 16px; color: #fff; padding-bottom: 2px; border-bottom: 2px solid #0084ff; transform: rotate(-90deg); ">OOC</span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {1}</span>&nbsp;<span style="position: relative; left: 3vh; font-size: 12px; color: #fff; padding-top: 2px; padding-left: 5px; padding-right: 5px; padding-bottom: 2px; border: 2px solid #7d7d7d; background: #555555c0; border-radius: 5px;">{0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{3}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{2}</div></div>',
			args = { id, name, message, time }
		})
    end
end)

RegisterNetEvent('chat:ooc2', function(id, name, message, time)
    local id1 = PlayerId()
    local id2 = GetPlayerFromServerId(id) 
    if id2 == id1 then
        TriggerEvent('chat:addMessage', {
			template = '<div style="position: relative;" class="chat-message ooc"><b><span style="position: absolute; top: 1vh; font-size: 16px; color: #fff; padding-bottom: 2px; border-bottom: 2px solid #0084ff; transform: rotate(-90deg); ">DARK</span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {1}</span>&nbsp;<span style="position: relative; left: 3vh; font-size: 12px; color: #fff; padding-top: 2px; padding-left: 5px; padding-right: 5px; padding-bottom: 2px; border: 2px solid #7d7d7d; background: #555555c0; border-radius: 5px;">{0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{3}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{2}</div></div>',
			args = { id, name, message, time }
		})
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id1)), GetEntityCoords(GetPlayerPed(id2)), true) < Config.OOCDistance then
        TriggerEvent('chat:addMessage', {
			template = '<div style="position: relative;" class="chat-message ooc"><b><span style="position: absolute; top: 1vh; font-size: 16px; color: #fff; padding-bottom: 2px; border-bottom: 2px solid #0084ff; transform: rotate(-90deg); ">DARK</span>&nbsp;</b><span style="position: relative; left: 3vh; font-size: 12px; color: #fff; border-radius: 40px;">Sender : {1}</span>&nbsp;<span style="position: relative; left: 3vh; font-size: 12px; color: #fff; padding-top: 2px; padding-left: 5px; padding-right: 5px; padding-bottom: 2px; border: 2px solid #7d7d7d; background: #555555c0; border-radius: 5px;">{0}</span>&nbsp;<span style="font-size: 12px; position: relative; left: 3vh; color: #ffffff88;">{3}</span><div style="position: relative; left: 3.3vh; font-size: 18px; font-weight: 300;">{2}</div></div>',
			args = { id, name, message, time }
		})
    end
end)