


## NOTIFY

- CLIENT

INFO > TriggerEvent('ac-lib:notify', "You can write anything here." , 4000, "info")
ERROR > TriggerEvent('ac-lib:notify', "You can write anything here." , 4000, "error")
SUCCESS > TriggerEvent('ac-lib:notify', "You can write anything here." , 4000, "success")

- SERVER

INFO > TriggerClientEvent('ac-lib:notify',source, "You can write anything here." , 4000, "info")
ERROR > TriggerClientEvent('ac-lib:notify', source,"You can write anything here." , 4000, "error")
SUCCESS > TriggerClientEvent('ac-lib:notify',source, "You can write anything here." , 4000, "success")


## PROGRESSBAR
exports['ac-lib']:progbaractive("Helpp", 4000)

## INFO BAR

- CLIENT

OPEN > TriggerEvent('ac-lib:openinfo', "Get Car" , "Go to motel and take car.")
CLOSE > TriggerEvent('ac-lib:closeinfo')

- SERVER

OPEN > TriggerClientEvent('ac-lib:openinfo', source,"Get Car" , "Go to motel and take car.")
CLOSE > TriggerClientEvent('ac-lib:closeinfo', source)



## QB Notify example edit ---------------------------------------------- 


function QBCore.Functions.Notify(text, texttype, length)
    length = length or 5000
    texttype = texttype or 'info'

    if texttype == "primary" then 
        texttype = "info"
    end



    TriggerEvent('ac-lib:notify', text , length, texttype)
end