ESX = nil
local ox_inventory = exports.ox_inventory --jak cos to eksportuje cały ox tu 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("drc_meth:Pickup")
AddEventHandler("drc_meth:Pickup", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)    
         	if exports.ox_inventory:AddItem(xPlayer.source, 'meth', 1) >= 450 then
				TriggerClientEvent('esx:showNotification', source, _U('maxpickup'))
			else
				exports.ox_inventory:AddItem(xPlayer.source, 'meth', 1) 
				local connect = {
					{
						["color"] = "16711680",
						["title"] = _U('Player')  ..GetPlayerName(source).." (".. xPlayer.identifier ..")",
						["description"] = _U('haspickupmeth'),
						["footer"] = {
						["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
						["icon_url"] = "",
						},
					}
				}	
				PerformHttpRequest(Config.methPickup, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - meth", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
            end			
end)


RegisterServerEvent('drc_meth:ProcessItems')
AddEventHandler('drc_meth:ProcessItems', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
	if exports.ox_inventory:GetItem(xPlayer.source, 'meth', 1) >= 3 then
exports.ox_inventory:RemoveItem(source, 'meth', 3)
exports.ox_inventory:AddItem(xPlayer.source, 'meth_bag', 1) 	
		local connect = {
			{
				["color"] = "16711680",
				["title"] = _U('Player')..GetPlayerName(source).." (".. xPlayer.identifier ..")",
				["description"] = _U('hasprocessmeth'),
				["footer"] = {
				["text"] = os.date('%H:%M - %d. %m. %Y', os.time()),
				["icon_url"] = "",
				},
			}
		}
			PerformHttpRequest(Config.methProcess, function(err, text, headers) end, 'POST', json.encode({username = "DRC_DRUGSYSTEM - meth", embeds = connect, avatar_url = Config.Image}), { ['Content-Type'] = 'application/json' })
		else
			TriggerClientEvent('esx:showNotification', source, _U('nomoremeth'))	
		end
	end)
