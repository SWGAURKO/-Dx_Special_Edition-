AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        JobsClass:loadJobs()
        CheckConfigDefaultSettings()
    end
end)

RegisterNetEvent("0r-jobcreator:Server:RegisterOxStash", function(stash)
    if not stash then return end
    local job = JobsClass:getJobByIdentity(stash.job_identity)
    if not job then return end
    local stashGroup = (job.perm and job.perm.type ~= "all") and {
        [job.perm.name] = 0
    } or false
    ox_inventory:RegisterStash(
        stash.unique_name,
        stash.name,
        stash.slots,
        stash.size,
        false,
        stashGroup
    )
end)

RegisterNetEvent("0r-jobcreator:Server:JobMarketItemSelected", function(src, market, selectedItem)
    local xPlayer = GetPlayerBySource(src)
    local job = JobsClass:getJobByIdentity(market.job_identity)
    if not job then
        SendNotifyServerside(nil,
            src,
            _t("JobCreator.job_not_exist"),
            "error"
        )
        return
    end
    if selectedItem.type == "sell" then
        local itemName = selectedItem.item_name
        local itemAmount = tonumber(selectedItem.amount)
        local moneyType = selectedItem.money_type
        local moneyPrice = tonumber(selectedItem.price)
        local hasItem, amount = PlayerHasItem(xPlayer, itemName)
        if hasItem and amount >= itemAmount then
            PlayerRemoveItem(xPlayer, itemName, itemAmount)
            PlayerAddMoney(xPlayer, moneyType, moneyPrice)
            SendNotifyServerside(job.notify_type,
                src,
                _t("JobCreator.market_item_bought", selectedItem.label),
                "success"
            )
        else
            SendNotifyServerside(job.notify_type,
                src,
                _t("JobCreator.dont_have_necessary_items",
                    (itemName .. " " .. (itemAmount - amount))),
                "error"
            )
            return
        end
    elseif selectedItem.type == "buy" then
        local itemName = selectedItem.item_name
        local itemAmount = tonumber(selectedItem.amount)
        local moneyType = selectedItem.money_type
        local moneyPrice = tonumber(selectedItem.price)
        local hasMoney = PlayerHasMoney(xPlayer, moneyType, moneyPrice)
        if not hasMoney then
            SendNotifyServerside(job.notify_type,
                src,
                _t("JobCreator.dont_have_enough_money", selectedItem.label),
                "error"
            )
            return
        end
        PlayerAddItem(xPlayer, itemName, itemAmount)
        PlayerRemoveMoney(xPlayer, moneyType, moneyPrice)
        SendNotifyServerside(job.notify_type,
            src,
            _t("JobCreator.market_item_bought", selectedItem.label),
            "success"
        )
    end
end)
