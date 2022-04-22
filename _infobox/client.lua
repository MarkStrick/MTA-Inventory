local screenW, screenH = guiGetScreenSize()
estado = {}
Timer = {}
alpha = {}
tick = {}
slotsUsed = {
	{false, "", ""},
	{false, "", ""},
	{false, "", ""},
	{false, "", ""},
	{false, "", ""},
	{false, "", ""},
	{false, "", ""},
}
function onStart()
    font = dxCreateFont("fontes/Roboto.ttf", screenH/75)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)

function addNotification(msg, tipo)
	if infos[tipo] then
		if (msg) then
			if (slotsUsed[1][1]) and (slotsUsed[2][1]) and (slotsUsed[3][1]) and (slotsUsed[4][1]) and (slotsUsed[5][1]) and (slotsUsed[6][1]) and (slotsUsed[7][1]) then
				slotsUsed[1][1] = slotsUsed[2][1]
				slotsUsed[1][2] = slotsUsed[2][2]
				slotsUsed[1][3] = slotsUsed[2][3]
				killTimer(Timer[1])
				Timer[1] = setTimer(function()
					estado[1][1] = false
				end, getTimerDetails(Timer[2]), 1)

				slotsUsed[2][1] = slotsUsed[3][1]
				slotsUsed[2][2] = slotsUsed[3][2]
				slotsUsed[2][3] = slotsUsed[3][3]
				killTimer(Timer[2])
				Timer[2] = setTimer(function()
					estado[2][1] = false
				end, getTimerDetails(Timer[3]), 1)

				slotsUsed[3][1] = slotsUsed[4][1]
				slotsUsed[3][2] = slotsUsed[4][2]
				slotsUsed[3][3] = slotsUsed[4][3]
				killTimer(Timer[3])
				Timer[3] = setTimer(function()
					estado[3][1] = false
				end, getTimerDetails(Timer[4]), 1)

				slotsUsed[4][1] = slotsUsed[5][1]
				slotsUsed[4][2] = slotsUsed[5][2]
				slotsUsed[4][3] = slotsUsed[5][3]
				killTimer(Timer[4])
				Timer[4] = setTimer(function()
					estado[4][1] = false
				end, getTimerDetails(Timer[5]), 1)

				slotsUsed[5][1] = slotsUsed[6][1]
				slotsUsed[5][2] = slotsUsed[6][2]
				slotsUsed[5][3] = slotsUsed[6][3]
				killTimer(Timer[5])
				Timer[5] = setTimer(function()
					estado[5][1] = false
				end, getTimerDetails(Timer[6]), 1)

				slotsUsed[6][1] = slotsUsed[7][1]
				slotsUsed[6][2] = slotsUsed[7][2]
				slotsUsed[6][3] = slotsUsed[7][3]
				killTimer(Timer[6])
				Timer[6] = setTimer(function()
					estado[6][1] = false
				end, getTimerDetails(Timer[7]), 1)

				slotsUsed[7][1] = false
				slotsUsed[7][2] = ""
				slotsUsed[7][3] = ""
				killTimer(Timer[7])
			end
			for i, v in pairs(slotsUsed) do
				if slotsUsed[i][1] == false then
					local tempo = (#tostring(msg) * 225)
					PlaySound()
					outputConsole("["..tipo.."]: "..msg)
					tick[i] = getTickCount()
					estado[i] = {}
					estado[i][1] = true
					alpha[i] = {}
					alpha[i][1] = 0
					slotsUsed[i][1] = true
					slotsUsed[i][2] = tipo
					slotsUsed[i][3] = msg
					Timer[i] = setTimer(function()
						estado[i][1] = false
					end, tempo, 1)
					break
				end
			end
		end
	end
end
addEvent("renderNotification", true)
addEventHandler("renderNotification", resourceRoot, addNotification)

function refreshSlots()
	for i, v in pairs(slotsUsed) do
		if slotsUsed[i][1] == false then
			for index, value in pairs(slotsUsed) do
				if slotsUsed[index][1] ~= false then
					if index ~= i and index > i then
						if isTimer(Timer[index]) then
							Timer[i] = setTimer(function()
								estado[i][1] = false
							end, getTimerDetails(Timer[index]), 1)
							killTimer(Timer[index])
						else
							estado[i][1] = false
						end
						slotsUsed[i][1] = slotsUsed[index][1]
						slotsUsed[i][2] = slotsUsed[index][2]
						slotsUsed[i][3] = slotsUsed[index][3]
						tick[i] = tick[index]
						tick[index] = nil
						estado[i] = {}
						alpha[i] = {}
						estado[i][1] = estado[index][1]
						alpha[i][1] = alpha[index][1]
						slotsUsed[index][1] = false
						slotsUsed[index][2] = ""
						slotsUsed[index][3] = ""
						estado[index][1] = false
						alpha[index][1] = false
						Timer[index] = nil
						break
					end
				end
			end
		end
	end
end

addEventHandler("onClientRender", root, function()
	if slotsUsed[1][1] then
		local length = dxGetTextWidth(slotsUsed[1][3], 1, font, true)
		local tipo = slotsUsed[1][2]
		if estado[1][1] == true then
			if alpha[1][1] <= 245 then
				alpha[1][1] = alpha[1][1] + 5
			end
		elseif estado[1][1] == false then
			if alpha[1][1] >= 5 then
				alpha[1][1] = alpha[1][1] - 5
			else
				slotsUsed[1][1] = false
				slotsUsed[1][2] = ""
				slotsUsed[1][3] = ""
				refreshSlots()
			end
		end
		local time = (#tostring(slotsUsed[1][3]) * 225)
		local barra = interpolateBetween (0, 0, 0, length + 65, 0, 0, (getTickCount()-tick[1])/time, "Linear")
		dxDrawRectangle(screenW * 0.0073, screenH * 0.6758, length + 65, screenH * 0.0573, tocolor(15, 15, 15, alpha[1][1]), false)
		dxDrawRectangle(screenW * 0.0073, screenH * 0.6758, barra, screenH * 0.0573, tocolor(25, 25, 25, alpha[1][1]), false)
		dxDrawImage(screenW * 0.0102, screenH * 0.6810, screenW * 0.0256, screenH * 0.0456, infos[tipo][4], 0, 0, 0, tocolor(infos[tipo][1], infos[tipo][2], infos[tipo][3], alpha[1][1]), false)
		dxDrawText(slotsUsed[1][3], screenW * 0.0432, screenH * 0.6758, screenW * 0.1852, screenH * 0.7331, tocolor(255, 255, 255, alpha[1][1]), 1.00, font, "left", "center", false, false, false, true, false)
    end
	if slotsUsed[2][1] then
		local length = dxGetTextWidth(slotsUsed[2][3], 1, font, true)
		local tipo = slotsUsed[2][2]
		if estado[2][1] == true then
			if alpha[2][1] <= 245 then
				alpha[2][1] = alpha[2][1] + 5
			end
		elseif estado[2][1] == false then
			if alpha[2][1] >= 5 then
				alpha[2][1] = alpha[2][1] - 5
			else
				slotsUsed[2][1] = false
				slotsUsed[2][2] = ""
				slotsUsed[2][3] = ""
				refreshSlots()
			end
		end
		local time = (#tostring(slotsUsed[2][3]) * 225)
		local barra = interpolateBetween (0, 0, 0, length + 65, 0, 0, (getTickCount()-tick[2])/time, "Linear")
		dxDrawRectangle(screenW * 0.0073, screenH * 0.6133, length + 65, screenH * 0.0573, tocolor(15, 15, 15, alpha[2][1]), false)
		dxDrawRectangle(screenW * 0.0073, screenH * 0.6133, barra, screenH * 0.0573, tocolor(25, 25, 25, alpha[2][1]), false)
		dxDrawImage(screenW * 0.0102, screenH * 0.6185, screenW * 0.0256, screenH * 0.0456, infos[tipo][4], 0, 0, 0, tocolor(infos[tipo][1], infos[tipo][2], infos[tipo][3], alpha[2][1]), false)
		dxDrawText(slotsUsed[2][3], screenW * 0.0432, screenH * 0.6133, screenW * 0.1852, screenH * 0.6706, tocolor(255, 255, 255, alpha[2][1]), 1.00, font, "left", "center", false, false, false, true, false)
    end
	if slotsUsed[3][1] then
		local length = dxGetTextWidth(slotsUsed[3][3], 1, font, true)
		local tipo = slotsUsed[3][2]
		if estado[3][1] == true then
			if alpha[3][1] <= 245 then
				alpha[3][1] = alpha[3][1] + 5
			end
		elseif estado[3][1] == false then
			if alpha[3][1] >= 5 then
				alpha[3][1] = alpha[3][1] - 5
			else
				slotsUsed[3][1] = false
				slotsUsed[3][2] = ""
				slotsUsed[3][3] = ""
				refreshSlots()
			end
		end
		local time = (#tostring(slotsUsed[3][3]) * 225)
		local barra = interpolateBetween (0, 0, 0, length + 65, 0, 0, (getTickCount()-tick[3])/time, "Linear")
		dxDrawRectangle(screenW * 0.0073, screenH * 0.5508, length + 65, screenH * 0.0573, tocolor(15, 15, 15, alpha[3][1]), false)
		dxDrawRectangle(screenW * 0.0073, screenH * 0.5508, barra, screenH * 0.0573, tocolor(25, 25, 25, alpha[3][1]), false)
		dxDrawImage(screenW * 0.0102, screenH * 0.5560, screenW * 0.0256, screenH * 0.0456, infos[tipo][4], 0, 0, 0, tocolor(infos[tipo][1], infos[tipo][2], infos[tipo][3], alpha[3][1]), false)
		dxDrawText(slotsUsed[3][3], screenW * 0.0432, screenH * 0.5508, screenW * 0.1852, screenH * 0.6081, tocolor(255, 255, 255, alpha[3][1]), 1.00, font, "left", "center", false, false, false, true, false)
    end
	if slotsUsed[4][1] then
		local length = dxGetTextWidth(slotsUsed[4][3], 1, font, true)
		local tipo = slotsUsed[4][2]
		if estado[4][1] == true then
			if alpha[4][1] <= 245 then
				alpha[4][1] = alpha[4][1] + 5
			end
		elseif estado[4][1] == false then
			if alpha[4][1] >= 5 then
				alpha[4][1] = alpha[4][1] - 5
			else
				slotsUsed[4][1] = false
				slotsUsed[4][2] = ""
				slotsUsed[4][3] = ""
				refreshSlots()
			end
		end
		local time = (#tostring(slotsUsed[4][3]) * 225)
		local barra = interpolateBetween (0, 0, 0, length + 65, 0, 0, (getTickCount()-tick[4])/time, "Linear")
		dxDrawRectangle(screenW * 0.0073, screenH * 0.4883, length + 65, screenH * 0.0573, tocolor(15, 15, 15, alpha[4][1]), false)
		dxDrawRectangle(screenW * 0.0073, screenH * 0.4883, barra, screenH * 0.0573, tocolor(25, 25, 25, alpha[4][1]), false)
		dxDrawImage(screenW * 0.0102, screenH * 0.4935, screenW * 0.0256, screenH * 0.0456, infos[tipo][4], 0, 0, 0, tocolor(infos[tipo][1], infos[tipo][2], infos[tipo][3], alpha[4][1]), false)
		dxDrawText(slotsUsed[4][3], screenW * 0.0432, screenH * 0.4883, screenW * 0.1852, screenH * 0.5456, tocolor(255, 255, 255, alpha[4][1]), 1.00, font, "left", "center", false, false, false, true, false)
    end
	if slotsUsed[5][1] then
		local length = dxGetTextWidth(slotsUsed[5][3], 1, font, true)
		local tipo = slotsUsed[5][2]
		if estado[5][1] == true then
			if alpha[5][1] <= 245 then
				alpha[5][1] = alpha[5][1] + 5
			end
		elseif estado[5][1] == false then
			if alpha[5][1] >= 5 then
				alpha[5][1] = alpha[5][1] - 5
			else
				slotsUsed[5][1] = false
				slotsUsed[5][2] = ""
				slotsUsed[5][3] = ""
				refreshSlots()
			end
		end
		local time = (#tostring(slotsUsed[5][3]) * 225)
		local barra = interpolateBetween (0, 0, 0, length + 65, 0, 0, (getTickCount()-tick[5])/time, "Linear")
		dxDrawRectangle(screenW * 0.0073, screenH * 0.4258, length + 65, screenH * 0.0573, tocolor(15, 15, 15, alpha[5][1]), false)
		dxDrawRectangle(screenW * 0.0073, screenH * 0.4258, barra, screenH * 0.0573, tocolor(25, 25, 25, alpha[5][1]), false)
		dxDrawImage(screenW * 0.0102, screenH * 0.4310, screenW * 0.0256, screenH * 0.0456, infos[tipo][4], 0, 0, 0, tocolor(infos[tipo][1], infos[tipo][2], infos[tipo][3], alpha[5][1]), false)
		dxDrawText(slotsUsed[5][3], screenW * 0.0432, screenH * 0.4258, screenW * 0.1852, screenH * 0.4831, tocolor(255, 255, 255, alpha[5][1]), 1.00, font, "left", "center", false, false, false, true, false)
    end
	if slotsUsed[6][1] then
		local length = dxGetTextWidth(slotsUsed[6][3], 1, font, true)
		local tipo = slotsUsed[6][2]
		if estado[6][1] == true then
			if alpha[6][1] <= 245 then
				alpha[6][1] = alpha[6][1] + 5
			end
		elseif estado[6][1] == false then
			if alpha[6][1] >= 5 then
				alpha[6][1] = alpha[6][1] - 5
			else
				slotsUsed[6][1] = false
				slotsUsed[6][2] = ""
				slotsUsed[6][3] = ""
				refreshSlots()
			end
		end
		local time = (#tostring(slotsUsed[6][3]) * 225)
		local barra = interpolateBetween (0, 0, 0, length + 65, 0, 0, (getTickCount()-tick[6])/time, "Linear")
		dxDrawRectangle(screenW * 0.0073, screenH * 0.3633, length + 65, screenH * 0.0573, tocolor(15, 15, 15, alpha[6][1]), false)
		dxDrawRectangle(screenW * 0.0073, screenH * 0.3633, barra, screenH * 0.0573, tocolor(25, 25, 25, alpha[6][1]), false)
		dxDrawImage(screenW * 0.0102, screenH * 0.3685, screenW * 0.0256, screenH * 0.0456, infos[tipo][4], 0, 0, 0, tocolor(infos[tipo][1], infos[tipo][2], infos[tipo][3], alpha[6][1]), false)
		dxDrawText(slotsUsed[6][3], screenW * 0.0432, screenH * 0.3633, screenW * 0.1852, screenH * 0.4206, tocolor(255, 255, 255, alpha[6][1]), 1.00, font, "left", "center", false, false, false, true, false)
    end
	if slotsUsed[7][1] then
		local length = dxGetTextWidth(slotsUsed[7][3], 1, font, true)
		local tipo = slotsUsed[7][2]
		if estado[7][1] == true then
			if alpha[7][1] <= 245 then
				alpha[7][1] = alpha[7][1] + 5
			end
		elseif estado[7][1] == false then
			if alpha[7][1] >= 5 then
				alpha[7][1] = alpha[7][1] - 5
			else
				slotsUsed[7][1] = false
				slotsUsed[7][2] = ""
				slotsUsed[7][3] = ""
				refreshSlots()
			end
		end
		local time = (#tostring(slotsUsed[7][3]) * 225)
		local barra = interpolateBetween (0, 0, 0, length + 65, 0, 0, (getTickCount()-tick[7])/time, "Linear")
		dxDrawRectangle(screenW * 0.0073, screenH * 0.3008, length + 65, screenH * 0.0573, tocolor(15, 15, 15, alpha[7][1]), false)
		dxDrawRectangle(screenW * 0.0073, screenH * 0.3008, barra, screenH * 0.0573, tocolor(25, 25, 25, alpha[7][1]), false)
		dxDrawImage(screenW * 0.0102, screenH * 0.3060, screenW * 0.0256, screenH * 0.0456, infos[tipo][4], 0, 0, 0, tocolor(infos[tipo][1], infos[tipo][2], infos[tipo][3], alpha[7][1]), false)
		dxDrawText(slotsUsed[7][3], screenW * 0.0432, screenH * 0.3008, screenW * 0.1852, screenH * 0.3581, tocolor(255, 255, 255, alpha[7][1]), 1.00, font, "left", "center", false, false, false, true, false)
    end
end)

function PlaySound()
	if not isTimer(timerSound) then
		timerSound = setTimer(function() end, 500, 1)
		local sound = playSound("sfx/sound.mp3")
		setSoundVolume(sound, 0.5)
	end
end