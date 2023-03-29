ESX = nil
local ox_inventory = exports.ox_inventory -- dodaje ox do esx
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("drc_opium:Pickup")
AddEventHandler("drc_opium:Pickup", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)    
	if exports.ox_inventory:AddItem(xPlayer.source, 'opium', 1) >= 450 then
		TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
	else
		exports.ox_inventory:AddItem(xPlayer.source, 'opium', 1) 
				local connect = {
					{
						["color"] = "16711680",
						["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
						["description"] = _U('haspickupopium'),
						["footer"] = {
						["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
						["icon_url"] = "",
						},
					}
				}	
				PerformHttpRequest(Config.opiumPickup, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - opium", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
            end			
end)


RegisterServerEvent('drc_opium:ProcessItems')
AddEventHandler('drc_opium:ProcessItems', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
if exports.ox_inventory:GetItem(xPlayer.source, 'opium', 1) >= 3 then
	exports.ox_inventory:RemoveItem(source, 'opium', 3)
	exports.ox_inventory:AddItem(xPlayer.source, 'opium_bag', 1)
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('hasprocessopium'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
			PerformHttpRequest(Config.opiumProcess, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - opium", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', source, _U('nomoreopium'))	
		end
	end)
