function addNotification(playerSource, msg, type)
	if getElementType(playerSource) == "player" then
		triggerClientEvent(playerSource, "renderNotification", resourceRoot, msg, type)
	end
end

function Anuncio(playerSource, commandName, ...)
	if hasObjectPermissionTo(playerSource, "command.ban", true) then
		for i, v in pairs(getElementsByType("player")) do
			local msg = table.concat ( { ... }, " " )
			local id = getElementData(playerSource, "ID") or "N/A"
			msg = string.gsub(msg, "#%x%x%x%x%x%x", "")
			msg = getPlayerName(playerSource).."#FFFFFF ("..id.."): "..msg
			triggerClientEvent(v, "renderNotification", resourceRoot, msg, "admin")
		end
	end
end
addCommandHandler("anunciar", Anuncio)