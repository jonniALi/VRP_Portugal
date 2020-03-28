local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_chatroles")

RegisterServerEvent('chat:init')
RegisterServerEvent('chat:addTemplate')
RegisterServerEvent('chat:addMessage')
RegisterServerEvent('chat:addSuggestion')
RegisterServerEvent('chat:removeSuggestion')
RegisterServerEvent('_chat:messageEntered')
RegisterServerEvent('chat:clear')
RegisterServerEvent('__cfx_internal:commandFallback')

AddEventHandler('_chat:messageEntered', function(author, color, message)
    if not message or not author then
        return
    end

    TriggerEvent('chatMessage', source, author, message)

    if not WasEventCanceled() then
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		if vRP.hasPermission({user_id,"owner.chattitle"}) then
			TriggerClientEvent('chatMessage', -1, "^1OWNER ^7| " .. author .. ": ^1" ..  message)
		elseif vRP.hasPermission({user_id,"admin.chattitle"}) then
			TriggerClientEvent('chatMessage', -1, "^1ADMIN ^7| " .. author .. ": ^1" ..  message)
		elseif vRP.hasPermission({user_id,"mod.chattitle"}) then	
			TriggerClientEvent('chatMessage', -1, "^1MOD ^7| " .. author .. ": ^1" ..  message)
		elseif vRP.hasGroup({user_id,"cop"}) then
			TriggerClientEvent('chatMessage', -1, "^4COP ^7| " .. author .. ": ^4" ..  message)
		elseif vRP.hasGroup({user_id,"ems"}) then
			TriggerClientEvent('chatMessage', -1, "^9EMS ^7| " .. author .. ": ^9" ..  message)
		elseif vRP.hasGroup({user_id,"Firefighter"}) then
			TriggerClientEvent('chatMessage', -1, "^3FIREFIGHTER ^7| " .. author .. ": ^3" ..  message)
		else
			TriggerClientEvent('chatMessage', -1, "OOC | " .. author,  { 128, 128, 128 }, message)
		end
    end

    print(author .. ': ' .. message)
end)

AddEventHandler('__cfx_internal:commandFallback', function(command)
    local name = GetPlayerName(source)

    TriggerEvent('chatMessage', source, name, '/' .. command)

    if not WasEventCanceled() then
		local user_id = vRP.getUserId({source})
		local player = vRP.getUserSource({user_id})
		if vRP.hasPermission({user_id,"owner.chattitle"}) then
			TriggerClientEvent('chatMessage', -1, "^1OWNER ^7| " .. name .. ": ^1" .. '/' .. command)
		elseif vRP.hasPermission({user_id,"admin.chattitle"}) then
			TriggerClientEvent('chatMessage', -1, "^1ADMIN ^7| " .. name .. ": ^1" .. '/' .. command)
		elseif vRP.hasPermission({user_id,"mod.chattitle"}) then	
			TriggerClientEvent('chatMessage', -1, "^1MOD ^7| " .. name .. ": ^1" .. '/' .. command)
		elseif vRP.hasGroup({user_id,"cop"}) then
			TriggerClientEvent('chatMessage', -1, "^4COP ^7| " .. name .. ": ^4" .. '/' .. command)
		elseif vRP.hasGroup({user_id,"ems"}) then
			TriggerClientEvent('chatMessage', -1, "^9EMS ^7| " .. name .. ": ^9" .. '/' .. command)
		elseif vRP.hasGroup({user_id,"Firefighter"}) then
			TriggerClientEvent('chatMessage', -1, "^3FIREFIGHTER ^7| " .. name .. ": ^3" .. '/' .. command)
		else
			TriggerClientEvent('chatMessage', -1, "OOC | " .. name, { 128, 128, 128 }, '/' .. command) 
		end	
    end

    CancelEvent()
end)

-- player join messages
-- AddEventHandler('playerConnecting', function()
    -- TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) .. ' joined.')
-- end)

-- AddEventHandler('playerDropped', function(reason)
    -- TriggerClientEvent('chatMessage', -1, '', { 255, 255, 255 }, '^2* ' .. GetPlayerName(source) ..' left (' .. reason .. ')')
-- end)

RegisterCommand('say', function(source, args, rawCommand)
    TriggerClientEvent('chatMessage', -1, (source == 0) and 'console' or GetPlayerName(source), { 255, 255, 255 }, rawCommand:sub(5))
end)