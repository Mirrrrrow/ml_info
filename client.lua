ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterCommand(Config.IDcommand, function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
    TriggerEvent(Config.Notify, Config.IDfarbe, Config.IDtitel, "Deine ID ist: " ..GetPlayerServerId(PlayerId()))
end)

RegisterCommand(Config.NearIDcommand, function(source, args, rawCommand)
	local playerPed = GetPlayerPed(-1)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerEvent(Config.Notify, Config.NearIDfarbe, Config.NearIDtitel, "Spieler ID in der Umgebung: " ..GetPlayerServerId(closestPlayer).. " ")
	else
		TriggerEvent(Config.Notify, Config.KeinSpielerfarbe, Config.KeinSpielertitel, Config.KeinSpielertext)
	end
end)

RegisterCommand(Config.OOCcommand, function(source, args)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local argString = table.concat(args, " ")
  
	if closestPlayer ~= -1 and closestDistance <= 10.0 then
		TriggerServerEvent('OOC', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), argString)
	else
		TriggerEvent(Config.Notify, Config.OOCfarbe, Config.OOCtitel, Config.OOCtext)
	end
end)

RegisterCommand(Config.Discordcommand, function()
    TriggerEvent(Config.Notify, Config.Discordfarbe, Config.Discordtitel, Config.Discordtext)
end)

RegisterCommand(Config.Teamspeakcommand, function()
    TriggerEvent(Config.Notify, Config.Teamspeakfarbe, Config.Teamspeaktitel, Config.Teamspeaktext)
end)