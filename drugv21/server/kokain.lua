ESX = nil
local ox_inventory = exports.ox_inventory
exports('Items', GetItem)
exports('ItemList', GetItem)
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("drc_coke:Pickup")
AddEventHandler("drc_coke:Pickup", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)    
         	if exports.ox_inventory:AddItem(xPlayer.source, 'coke', 1) >= 450 then
				TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
			else
				exports.ox_inventory:AddItem(xPlayer.source, 'coke', 1)
				local connect = {
					{
						["color"] = "16711680",
						["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
						["description"] = _U('haspickupcoke'),
						["footer"] = {
						["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
						["icon_url"] = "",
						},
					}
				}	
				PerformHttpRequest(Config.CokePickup, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - COKE", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
           end			
end)


RegisterServerEvent('drc_coke:ProcessItems')
AddEventHandler('drc_coke:ProcessItems', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
	if exports.ox_inventory:GetItem(xPlayer.source, 'coke', 1) >= 3 then
exports.ox_inventory:RemoveItem(source, 'coke', 3)
exports.ox_inventory:AddItem(xPlayer.source, 'coke_porch', 1)
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('hasprocesscoke'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
			PerformHttpRequest(Config.CokeProcess, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - COKE", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', source, _U('nomorecoke'))	
		end
	end)
