ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- ez zrobione i chyba działa :))
RegisterCommand('dealer', function(source, args, rawcommand)
    xPlayer = ESX.GetPlayerFromId(source)
    drugToSell = {
        type = '',
        label = '',
        count = 0,
        i = 0,
        price = 0,
    }
    for k, v in pairs(Config.drugs) do
        item = xPlayer.getInventoryItem(k)
            
        if item == nil then
            return        
        end
            
        count = item.count
        drugToSell.i = drugToSell.i + 1
        drugToSell.type = k
        drugToSell.label = item.label
        
        if count >= 5 then
            drugToSell.count = math.random(1, 5)
        elseif count > 0 then
            drugToSell.count = math.random(1, count)
        end

        if drugToSell.count ~= 0 then
            drugToSell.price = drugToSell.count * v + math.random(1, 300)
            TriggerClientEvent('Kacperek_selldrugsv2:findClient', source, drugToSell)
            break
        end
        
        if ESX.Table.SizeOf(Config.drugs) == drugToSell.i and drugToSell.count == 0 then
            xPlayer.showNotification(Config.notify.nodrugs, 6)
        end
    end
end, false)

RegisterServerEvent('Kacperek_selldrugsv2:pay')
AddEventHandler('Kacperek_selldrugsv2:pay', function(drugToSell)
    xPlayer = ESX.GetPlayerFromId(source)
    exports.ox_inventory:RemoveItem(drugToSell.type, drugToSell.count)
    if Config.account == 'money' then
        exports.ox_inventory:AddItem(drugToSell.price)
    else
        exports.ox_inventory:AddItem(Config.account, drugToSell.price)
    end
end)

RegisterServerEvent('Kacperek_selldrugsv2:notifycops')
AddEventHandler('Kacperek_selldrugsv2:notifycops', function(drugToSell)
    TriggerClientEvent('Kacperek_selldrugsv2:notifyPolice', -1, drugToSell.coords)
end)

ESX.RegisterServerCallback('Kacperek_selldrugsv2:getPoliceCount', function(source, cb)
    count = 0

    for _, playerId in pairs(ESX.GetPlayers()) do
        xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer.job.name == 'police' then
            count = count + 1
        end
    end

    cb(count)
end)
