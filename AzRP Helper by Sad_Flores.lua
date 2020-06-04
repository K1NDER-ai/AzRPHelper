script_name("AzRP Helper by Sad_Flores")
script_author("Sad_Flores")
script_version('1.3.b')

require "lib.moonloader"

local imgui = require 'imgui'
local encoding = require 'encoding'

local samp = require 'samp.events'
local sampev = require 'lib.samp.events'

local bNotf, notf = pcall(import, "imgui_notf.lua")

local memory = require 'memory'
local inicfg = require 'inicfg'

local load_settings = inicfg.load({
	settings =
	{
		fast_connect_active = true,
		anti_afk_active = false,
		azrp_emu_active = false,
		anti_stealer_active = true,
		buffer_cleaner_active = true,
		tuning_fix_active = true,
		fast_load_active = true,
		new_tab_active = false
	}
})


encoding.default = 'CP1251' 
u8 = encoding.UTF8

local mapp = {
	["Тюнинг"] = {
	1000,
	1001,
	1002,
	1003,
	1004,
	1005,
	1006,
	1007,
	1011,
	1012,
	1013,
	1014,
	1015,
	1016,
	1017,
	1018,
	1019,
	1020,
	1021,
	1022,
	1023,
	1024,
	1025,
	1026,
	1027,
	1028,
	1029,
	1030,
	1031,
	1032,
	1033,
	1034,
	1035,
	1036,
	1037,
	1038,
	1039,
	1040,
	1041,
	1042,
	1043,
	1044,
	1045,
	1046,
	1047,
	1048,
	1049,
	1050,
	1051,
	1052,
	1053,
	1054,
	1055,
	1056,
	1057,
	1058,
	1059,
	1060,
	1061,
	1062,
	1063,
	1064,
	1065,
	1066,
	1067,
	1068,
	1069,
	1070,
	1071,
	1072,
	1073,
	1074,
	1075,
	1076,
	1077,
	1078,
	1079,
	1080,
	1081,
	1082,
	1083,
	1084,
	1085,
	1088,
	1089,
	1090,
	1091,
	1092,
	1093,
	1094,
	1095,
	1096,
	1097,
	1098,
	1099,
	1100,
	1101,
	1102,
	1103,
	1104,
	1105,
	1106,
	1107,
	1108,
	1110,
	1111,
	1112,
	1113,
	1114,
	1115,
	1116,
	1117,
	1118,
	1119,
	1120,
	1121,
	1122,
	1123,
	1124,
	1125,
	1126,
	1127,
	1128,
	1129,
	1130,
	1131,
	1132,
	1133,
	1134,
	1135,
	1136,
	1137,
	1138,
	1139,
	1140,
	1141,
	1142,
	1143,
	1144,
	1145,
	1146,
	1147,
	1148,
	1149,
	1150,
	1151,
	1152,
	1153,
	1154,
	1155,
	1156,
	1157,
	1158,
	1159,
	1160,
	1161,
	1162,
	1163,
	1164,
	1165,
	1166,
	1167,
	1168,
	1169,
	1170,
	1171,
	1172,
	1173,
	1174,
	1175,
	1176,
	1177,
	1178,
	1179,
	1180,
	1181,
	1182,
	1183,
	1184,
	1185,
	1186,
	1187,
	1188,
	1189,
	1190,
	1191,
	1192,
	1193,
	1327
    }
}

function apply_custom_style()
   imgui.SwitchContext()
   local style = imgui.GetStyle()
   local colors = style.Colors
   local clr = imgui.Col
   local ImVec4 = imgui.ImVec4
   local ImVec2 = imgui.ImVec2

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 15.0
    style.FramePadding = ImVec2(5, 5)
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 15.0
    style.GrabMinSize = 15.0
    style.GrabRounding = 7.0
    style.ChildWindowRounding = 8.0
    style.FrameRounding = 6.0
  

      colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
      colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
      colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
      colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
      colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
      colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
      colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
      colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
      colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
      colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
      colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
      colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
      colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
      colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
      colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
      colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
      colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
      colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
      colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
      colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
      colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
      colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
      colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
      colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
      colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
      colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
      colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
      colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
      colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
      colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
      colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
      colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
      colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
      colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
      colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end
apply_custom_style()

local test_text_buffer = imgui.ImBuffer(256)
local main_window_state = imgui.ImBool(false)

local fast_connect_active = imgui.ImBool(load_settings.settings.fast_connect_active)
local anti_afk_active = imgui.ImBool(load_settings.settings.anti_afk_active)
local azrp_emu_active = imgui.ImBool(load_settings.settings.azrp_emu_active)
local anti_stealer_active = imgui.ImBool(load_settings.settings.anti_stealer_active)
local buffer_cleaner_active = imgui.ImBool(load_settings.settings.buffer_cleaner_active)
local tuning_fix_active = imgui.ImBool(load_settings.settings.tuning_fix_active)
local fast_load_active = imgui.ImBool(load_settings.settings.fast_load_active)
local new_tab_active = imgui.ImBool(false)

local delete_players = imgui.ImBool(false)
local delete_cars = imgui.ImBool(false)

local central_del_car = false
local central_del_player = false

local npc, infnpc = {}, {}
local car, infcar = {}, {}

local tab_downloading = true

local function send_player_stream(id, i)
	if i then
		local bs = raknetNewBitStream()
		raknetBitStreamWriteInt16(bs, id)
		raknetBitStreamWriteInt8(bs, i[1])
		raknetBitStreamWriteInt32(bs, i[2])
		raknetBitStreamWriteFloat(bs, i[3].x)
		raknetBitStreamWriteFloat(bs, i[3].y)
		raknetBitStreamWriteFloat(bs, i[3].z)
		raknetBitStreamWriteFloat(bs, i[4])
		raknetBitStreamWriteInt32(bs, i[5])
		raknetBitStreamWriteInt8(bs, i[6])
		raknetEmulRpcReceiveBitStream(32, bs)
	end
end

function imgui.TextQuestion(text)
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(450)
        imgui.TextUnformatted(text)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function imgui.OnDrawFrame()
	if main_window_state.v then
		imgui.SetNextWindowSize(imgui.ImVec2(870, 460), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'AzRP Helper | Sad_Flores', imgui.WindowFlags.NoCollapse, imgui.WindowFlags.NoResize)
		
		imgui.BeginChild("menu", imgui.ImVec2(165, 400), true)
		
		if imgui.Button(u8"Основные настройки", imgui.ImVec2(-1, 25)) then menu = 1 end
		if imgui.Button(u8"Бинды и таймеры", imgui.ImVec2(-1, 25)) then menu = 2 end
		
		imgui.EndChild()
		
		imgui.SameLine()
		if menu == 1 then
			imgui.BeginChild("basic", imgui.ImVec2(665, 400), true)
			
			if imgui.Checkbox('FastConnect', fast_connect_active) then
				memory.fill(sampGetBase() + 0x2D3C45, 0, 2, true)
				
				load_settings.settings.fast_connect_active = not load_settings.settings.fast_connect_active
				inicfg.save(load_settings)
				
				notf.addNotification("FastConnect изменен!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Быстрое подключение к серверу при высоком онлайне.')
			
			if imgui.Checkbox('AntiAfk', anti_afk_active) then
				writeMemory(7634870, 1, 1, 1)
				writeMemory(7635034, 1, 1, 1)
				memory.fill(7623723, 144, 8)
				memory.fill(5499528, 144, 6)
				
				load_settings.settings.anti_afk_active = not load_settings.settings.anti_afk_active
				inicfg.save(load_settings)
				
				notf.addNotification("AntiAfk изменен!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Отключение АФК при сворачивании игры.')
			
			if imgui.Checkbox('AzRP Launcher(Emulator)', azrp_emu_active) then
				notf.addNotification("Состоит в разработке!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Получаем бонусы от AzRP без лаунчера и нелегальной проверки твоей папки.')

			if imgui.Checkbox('AntiStealer', anti_stealer_active) then
				notf.addNotification("Состоит в разработке!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Перехват всей отправки твоих данных на чужие сайты.')
			
			if imgui.Checkbox('BufferCleaner', buffer_cleaner_active) then
				local call1 = callFunction(0x53C500, 2, 2, true, true)
				local call2 = callFunction(0x53C810, 1, 1, true)
				local call3 = callFunction(0x40CF80, 0, 0)
				local call4 = callFunction(0x4090A0, 0, 0)
				local call5 = callFunction(0x5A18B0, 0, 0)
				local call6 = callFunction(0x707770, 0, 0)
				local pX, pY, pZ = getCharCoordinates(PLAYER_PED)
				requestCollision(pX, pY)
				loadScene(pX, pY, pZ)
				
				load_settings.settings.buffer_cleaner_active = not load_settings.settings.buffer_cleaner_active
				inicfg.save(load_settings)
				
				notf.addNotification("BufferCleaner изменен!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Очистка буффера памяти для минимализирования краша.')
			
			if imgui.Checkbox('TuningFix', tuning_fix_active) then
				load_settings.settings.tuning_fix_active = not load_settings.settings.tuning_fix_active
				inicfg.save(load_settings)
				
				notf.addNotification("TuningFix изменен!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Исправление бага когда из-за тюнинга ТС кидает в разные стороны.')
			
			if imgui.Checkbox('FastLoad', fast_load_active) then
				load_settings.settings.fast_load_active = not load_settings.settings.fast_load_active
				inicfg.save(load_settings)
				
				notf.addNotification("FastLoad изменен!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Быстрая загрузка SA:MPa.')
			
			if imgui.Checkbox('NewTab', new_tab_active) then
				if tab_downloading == true then
					local dlstatus = require('moonloader').download_status
					local file_path = getWorkingDirectory() .. '/ARZ_Assistant_Custom_Tab.lua'
					downloadUrlToFile("https://raw.githubusercontent.com/K1NDER-ai/AzRPHelper/master/ARZ_Assistant_Custom_Tab.lua", file_path,
					function(id3, status1, p13, p23)
						if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
							notf.addNotification(string.format('Загружено %d из %d.', p13, p23), 4, 2)
						elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
							notf.addNotification("Загрузка завершена!", 4, 2)
							lua_thread.create(function() wait(500) reloadScripts() end)
						end
					end
					)
				elseif tab_downloading == false then
					local file_path = getWorkingDirectory() .. '/ARZ_Assistant_Custom_Tab.lua'
					os.remove(file_path)
					notf.addNotification("NewTab был успешно удален!", 4, 2)
					lua_thread.create(function() wait(500) reloadScripts() end)
				end
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Новый и приятный TAB на imgui(Будет произведена автоматическая загрузка доп.компонентов).')
			
			if imgui.Checkbox('DeletePlayer`s', delete_players) then
				central_del_player = not central_del_player
				
				for _, handle in ipairs(getAllChars()) do
					if doesCharExist(handle) then
						local _, id = sampGetPlayerIdByCharHandle(handle)
						if id ~= myid then
							emul_rpc('onPlayerStreamOut', { id })
							npc[#npc + 1] = id
						end
					end
				end
				
				if central_del_player == false then
					for i = 1, #npc do
						send_player_stream(npc[i], infnpc[npc[i]])
						npc[i] = nil
					end
				end
				notf.addNotification("DeletePlayer`s изменен!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Удаляет и после блокирует игроков в зоне стрима(Возможен бан за коллизию).')
			
			if imgui.Checkbox('DeleteCar`s', delete_cars) then
				central_del_car = not central_del_car
				
				for k, v in ipairs(getAllVehicles()) do
					deleteCar(v)
				end
				notf.addNotification("DeleteCar`s изменен!", 4, 2)
			end
			imgui.SameLine()
			imgui.TextQuestion(u8'Удаляет а после блокирует транспорт в зоне стрима(Возможен бан за коллизию).')
			
			imgui.EndChild()
		end
		
		imgui.SameLine()
		if menu == 2 then
			imgui.BeginChild("other", imgui.ImVec2(665, 400), true)
			imgui.Text("3")
			imgui.EndChild()
		end
		
		imgui.End()
	end
end

function main()
	while not isSampAvailable() do wait(0) end
	
	local file_path = getWorkingDirectory() .. '/ARZ_Assistant_Custom_Tab.lua'
	if doesFileExist(file_path) == true then
		new_tab_active = imgui.ImBool(true)
		tab_downloading = false
	elseif doesFileExist(file_path) == false then
		new_tab_active = imgui.ImBool(false)
		tab_downloading = true
	end
	
	inicfg.save(load_settings)
	local time = os.clock() + 300
	while true do
		if time < os.clock() then
			autoupdate("https://raw.githubusercontent.com/K1NDER-ai/AzRPHelper/master/version.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/K1NDER-ai/AzRPHelper/master/version.json")
			time = os.clock() + 300
			
			if load_settings.settings.buffer_cleaner_active == true and memory.read(0x8E4CB4, 4, true) > 314572800 then
				local cln1 = callFunction(0x53C500, 2, 2, true, true)
				local cln2 = callFunction(0x53C810, 1, 1, true)
				local cln3 = callFunction(0x53BED0, 0, 0)
				local cln4 = callFunction(0x40CF80, 0, 0)
				local cln5 = callFunction(0x53C440, 0, 0)
				local cln6 = callFunction(0x707770, 0, 0)
				local cln7 = callFunction(0x5A18B0, 0, 0)
				local cln8 = callFunction(0x53C4A0, 0, 0)
				local cln9 = callFunction(0x53C240, 0, 0)
				local cln10 = callFunction(0x4090A0, 0, 0)
				local cln11 = callFunction(0x409760, 0, 0)
				local cln12 = callFunction(0x409210, 0, 0)
				local cln13 = callFunction(0x40D7C0, 1, 1, -1)
				local cln14 = callFunction(0x40E4E0, 0, 0)
				local cln15 = callFunction(0x70C950, 0, 0)
				local cln16 = callFunction(0x408CB0, 0, 0)
				local cln17 = callFunction(0x40E460, 0, 0)
				local cln18 = callFunction(0x407A10, 0, 0)
				local cln19 = callFunction(0x40B3A0, 0, 0)
				local detectX, detectY, detectZ = getCharCoordinates(PLAYER_PED)
				requestCollision(detectX, detectY)
				loadScene(detectX, detectY, detectZ)
			end
		end
		
		wait(0)
		if wasKeyPressed(0x34) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
			main_window_state.v = not main_window_state.v
		end
		imgui.Process = main_window_state.v
	end
end

local function patch()
	if load_settings.settings.fast_load_active == true then
		if memory.getuint8(0x748C2B) == 0xE8 then
			memory.fill(0x748C2B, 0x90, 5, true)
		elseif memory.getuint8(0x748C7B) == 0xE8 then
			memory.fill(0x748C7B, 0x90, 5, true)
		end
		if memory.getuint8(0x5909AA) == 0xBE then
			memory.write(0x5909AB, 1, 1, true)
		end
		if memory.getuint8(0x590A1D) == 0xBE then
			memory.write(0x590A1D, 0xE9, 1, true)
			memory.write(0x590A1E, 0x8D, 4, true)
		end
		if memory.getuint8(0x748C6B) == 0xC6 then
			memory.fill(0x748C6B, 0x90, 7, true)
		elseif memory.getuint8(0x748CBB) == 0xC6 then
			memory.fill(0x748CBB, 0x90, 7, true)
		end
		if memory.getuint8(0x590AF0) == 0xA1 then
			memory.write(0x590AF0, 0xE9, 1, true)
			memory.write(0x590AF1, 0x140, 4, true)
		end
	end
end

patch()

function onReceiveRpc(id,bs)
    if sampIsLocalPlayerSpawned() then 
		local model = raknetBitStreamReadInt32(bs)

		if filt(model) and central_del_car == true then 
			count_delete_obj = count_delete_obj + 1
			return false 
		end
		if id == 91 and load_settings.settings.tuning_fix_active == true then
			local handle = storeCarCharIsInNoSave(playerPed)
			if handle > 0 then
				local RPC = ReadRPC(bs)
				local pint = getCarPointer(handle)
				if memory.getfloat(pint + 0x49C) == 0 and memory.getfloat(pint + 0x4A0) == 0 then
					return false
				end
				local distance = math.abs(math.sqrt(RPC.x ^ 2 + RPC.y ^ 2 + RPC.z ^ 2))
				local vx,vy,vz = getCarSpeedVector(handle)
				if vx ~= 0 and vy ~= 0 and vz ~= 0 then
					local fAngle = math.deg(math.atan2(vy - RPC.y, vx - RPC.x))
					local fAngle = tonumber(string.format("%.2f",(fAngle < 0 and 360 - math.abs(fAngle) or fAngle)))
					local sAngle = (getCarHeading(handle) + 90)
					local sAngle = tonumber(string.format("%.2f",(sAngle > 360 and sAngle - 360 or sAngle)))
					if (sAngle - 12) <= fAngle and (sAngle + 12) >= fAngle then
						k = distance / math.sqrt((vx ^ 2) + (vy ^ 2) + (vz ^ 2))
						return WriteRPC({x = vx * k,y = vy * k,z = vz * k})
					end
				end
				return false
			end
		end
    end
end

function ReadRPC(bs)
    raknetBitStreamSetReadOffset(bs, 8)
    return {
        x = raknetBitStreamReadFloat(bs),
        y = raknetBitStreamReadFloat(bs),
        z = raknetBitStreamReadFloat(bs)
    }
end

function WriteRPC(velocity)
    local bs = raknetNewBitStream()
    raknetBitStreamWriteBool(bs,false)
    raknetBitStreamWriteFloat(bs,velocity.x)
    raknetBitStreamWriteFloat(bs,velocity.y)
    raknetBitStreamWriteFloat(bs,velocity.z)
    return bs
end

function FIND(model, values)
    for k, v in pairs(mapp[values]) do
        if model == v then 
            return true 
        end
    end
    return false
end

function filt(model)
	if central_del_car == true then
		FIND(model, "Тюнинг") 
	end
    return false
end

function sampev.onVehicleStreamIn(vehicleId, data)
	if central_del_car == true then
		return false
	end
end

function myposition()
    local positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
    local str = positionX .. ", " .. positionY .. ", " .. positionZ
    return str
end

function sampev.onPlayerStreamIn(playerId, team, model, position, rotation, color, fightingStyle)
	infnpc[playerId] = 
	{ 
		team, 
		model, 
		position, 
		rotation, 
		color, 
		fightingStyle 
	}
	npc[#npc + 1] = playerId
	if central_del_player == true then
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		
		if playerId ~= myid and position == myposition() then
			sampAddChatMessage('{228B22}КОЛЛИЗИЯ БЛЯТЬ.', 0x228B22)
		end
		return false
	end
end

function emul_rpc(hook, parameters)
    local bs_io = require 'samp.events.bitstream_io'
    local handler = require 'samp.events.handlers'
    local extra_types = require 'samp.events.extra_types'
    local hooks = {

        --[[ Outgoing rpcs
        ['onSendEnterVehicle'] = { 'int16', 'bool8', 26 },
        ['onSendClickPlayer'] = { 'int16', 'int8', 23 },
        ['onSendClientJoin'] = { 'int32', 'int8', 'string8', 'int32', 'string8', 'string8', 'int32', 25 },
        ['onSendEnterEditObject'] = { 'int32', 'int16', 'int32', 'vector3d', 27 },
        ['onSendCommand'] = { 'string32', 50 },
        ['onSendSpawn'] = { 52 },
        ['onSendDeathNotification'] = { 'int8', 'int16', 53 },
        ['onSendDialogResponse'] = { 'int16', 'int8', 'int16', 'string8', 62 },
        ['onSendClickTextDraw'] = { 'int16', 83 },
        ['onSendVehicleTuningNotification'] = { 'int32', 'int32', 'int32', 'int32', 96 },
        ['onSendChat'] = { 'string8', 101 },
        ['onSendClientCheckResponse'] = { 'int8', 'int32', 'int8', 103 },
        ['onSendVehicleDamaged'] = { 'int16', 'int32', 'int32', 'int8', 'int8', 106 },
        ['onSendEditAttachedObject'] = { 'int32', 'int32', 'int32', 'int32', 'vector3d', 'vector3d', 'vector3d', 'int32', 'int32', 116 },
        ['onSendEditObject'] = { 'bool', 'int16', 'int32', 'vector3d', 'vector3d', 117 },
        ['onSendInteriorChangeNotification'] = { 'int8', 118 },
        ['onSendMapMarker'] = { 'vector3d', 119 },
        ['onSendRequestClass'] = { 'int32', 128 },
        ['onSendRequestSpawn'] = { 129 },
        ['onSendPickedUpPickup'] = { 'int32', 131 },
        ['onSendMenuSelect'] = { 'int8', 132 },
        ['onSendVehicleDestroyed'] = { 'int16', 136 },
        ['onSendQuitMenu'] = { 140 },
        ['onSendExitVehicle'] = { 'int16', 154 },
        ['onSendUpdateScoresAndPings'] = { 155 },
        ['onSendGiveDamage'] = { 'int16', 'float', 'int32', 'int32', 115 },
        ['onSendTakeDamage'] = { 'int16', 'float', 'int32', 'int32', 115 },]]

        -- Incoming rpcs
        ['onInitGame'] = { 139 },
        ['onPlayerJoin'] = { 'int16', 'int32', 'bool8', 'string8', 137 },
        ['onPlayerQuit'] = { 'int16', 'int8', 138 },
        ['onRequestClassResponse'] = { 'bool8', 'int8', 'int32', 'int8', 'vector3d', 'float', 'Int32Array3', 'Int32Array3', 128 },
        ['onRequestSpawnResponse'] = { 'bool8', 129 },
        ['onSetPlayerName'] = { 'int16', 'string8', 'bool8', 11 },
        ['onSetPlayerPos'] = { 'vector3d', 12 },
        ['onSetPlayerPosFindZ'] = { 'vector3d', 13 },
        ['onSetPlayerHealth'] = { 'float', 14 },
        ['onTogglePlayerControllable'] = { 'bool8', 15 },
        ['onPlaySound'] = { 'int32', 'vector3d', 16 },
        ['onSetWorldBounds'] = { 'float', 'float', 'float', 'float', 17 },
        ['onGivePlayerMoney'] = { 'int32', 18 },
        ['onSetPlayerFacingAngle'] = { 'float', 19 },
        --['onResetPlayerMoney'] = { 20 },
        --['onResetPlayerWeapons'] = { 21 },
        ['onGivePlayerWeapon'] = { 'int32', 'int32', 22 },
        --['onCancelEdit'] = { 28 },
        ['onSetPlayerTime'] = { 'int8', 'int8', 29 },
        ['onSetToggleClock'] = { 'bool8', 30 },
        ['onPlayerStreamIn'] = { 'int16', 'int8', 'int32', 'vector3d', 'float', 'int32', 'int8', 32 },
        ['onSetShopName'] = { 'string256', 33 },
        ['onSetPlayerSkillLevel'] = { 'int16', 'int32', 'int16', 34 },
        ['onSetPlayerDrunk'] = { 'int32', 35 },
        ['onCreate3DText'] = { 'int16', 'int32', 'vector3d', 'float', 'bool8', 'int16', 'int16', 'encodedString4096', 36 },
        --['onDisableCheckpoint'] = { 37 },
        ['onSetRaceCheckpoint'] = { 'int8', 'vector3d', 'vector3d', 'float', 38 },
        --['onDisableRaceCheckpoint'] = { 39 },
        --['onGamemodeRestart'] = { 40 },
        ['onPlayAudioStream'] = { 'string8', 'vector3d', 'float', 'bool8', 41 },
        --['onStopAudioStream'] = { 42 },
        ['onRemoveBuilding'] = { 'int32', 'vector3d', 'float', 43 },
        ['onCreateObject'] = { 44 },
        ['onSetObjectPosition'] = { 'int16', 'vector3d', 45 },
        ['onSetObjectRotation'] = { 'int16', 'vector3d', 46 },
        ['onDestroyObject'] = { 'int16', 47 },
        ['onPlayerDeathNotification'] = { 'int16', 'int16', 'int8', 55 },
        ['onSetMapIcon'] = { 'int8', 'vector3d', 'int8', 'int32', 'int8', 56 },
        ['onRemoveVehicleComponent'] = { 'int16', 'int16', 57 },
        ['onRemove3DTextLabel'] = { 'int16', 58 },
        ['onPlayerChatBubble'] = { 'int16', 'int32', 'float', 'int32', 'string8', 59 },
        ['onUpdateGlobalTimer'] = { 'int32', 60 },
        ['onShowDialog'] = { 'int16', 'int8', 'string8', 'string8', 'string8', 'encodedString4096', 61 },
        ['onDestroyPickup'] = { 'int32', 63 },
        ['onLinkVehicleToInterior'] = { 'int16', 'int8', 65 },
        ['onSetPlayerArmour'] = { 'float', 66 },
        ['onSetPlayerArmedWeapon'] = { 'int32', 67 },
        ['onSetSpawnInfo'] = { 'int8', 'int32', 'int8', 'vector3d', 'float', 'Int32Array3', 'Int32Array3', 68 },
        ['onSetPlayerTeam'] = { 'int16', 'int8', 69 },
        ['onPutPlayerInVehicle'] = { 'int16', 'int8', 70 },
        --['onRemovePlayerFromVehicle'] = { 71 },
        ['onSetPlayerColor'] = { 'int16', 'int32', 72 },
        ['onDisplayGameText'] = { 'int32', 'int32', 'string32', 73 },
        --['onForceClassSelection'] = { 74 },
        ['onAttachObjectToPlayer'] = { 'int16', 'int16', 'vector3d', 'vector3d', 75 },
        ['onInitMenu'] = { 76 },
        ['onShowMenu'] = { 'int8', 77 },
        ['onHideMenu'] = { 'int8', 78 },
        ['onCreateExplosion'] = { 'vector3d', 'int32', 'float', 79 },
        ['onShowPlayerNameTag'] = { 'int16', 'bool8', 80 },
        ['onAttachCameraToObject'] = { 'int16', 81 },
        ['onInterpolateCamera'] = { 'bool', 'vector3d', 'vector3d', 'int32', 'int8', 82 },
        ['onGangZoneStopFlash'] = { 'int16', 85 },
        ['onApplyPlayerAnimation'] = { 'int16', 'string8', 'string8', 'bool', 'bool', 'bool', 'bool', 'int32', 86 },
        ['onClearPlayerAnimation'] = { 'int16', 87 },
        ['onSetPlayerSpecialAction'] = { 'int8', 88 },
        ['onSetPlayerFightingStyle'] = { 'int16', 'int8', 89 },
        ['onSetPlayerVelocity'] = { 'vector3d', 90 },
        ['onSetVehicleVelocity'] = { 'bool8', 'vector3d', 91 },
        ['onServerMessage'] = { 'int32', 'string32', 93 },
        ['onSetWorldTime'] = { 'int8', 94 },
        ['onCreatePickup'] = { 'int32', 'int32', 'int32', 'vector3d', 95 },
        ['onMoveObject'] = { 'int16', 'vector3d', 'vector3d', 'float', 'vector3d', 99 },
        ['onEnableStuntBonus'] = { 'bool', 104 },
        ['onTextDrawSetString'] = { 'int16', 'string16', 105 },
        ['onSetCheckpoint'] = { 'vector3d', 'float', 107 },
        ['onCreateGangZone'] = { 'int16', 'vector2d', 'vector2d', 'int32', 108 },
        ['onPlayCrimeReport'] = { 'int16', 'int32', 'int32', 'int32', 'int32', 'vector3d', 112 },
        ['onGangZoneDestroy'] = { 'int16', 120 },
        ['onGangZoneFlash'] = { 'int16', 'int32', 121 },
        ['onStopObject'] = { 'int16', 122 },
        ['onSetVehicleNumberPlate'] = { 'int16', 'string8', 123 },
        ['onTogglePlayerSpectating'] = { 'bool32', 124 },
        ['onSpectatePlayer'] = { 'int16', 'int8', 126 },
        ['onSpectateVehicle'] = { 'int16', 'int8', 127 },
        ['onShowTextDraw'] = { 134 },
        ['onSetPlayerWantedLevel'] = { 'int8', 133 },
        ['onTextDrawHide'] = { 'int16', 135 },
        ['onRemoveMapIcon'] = { 'int8', 144 },
        ['onSetWeaponAmmo'] = { 'int8', 'int16', 145 },
        ['onSetGravity'] = { 'float', 146 },
        ['onSetVehicleHealth'] = { 'int16', 'float', 147 },
        ['onAttachTrailerToVehicle'] = { 'int16', 'int16', 148 },
        ['onDetachTrailerFromVehicle'] = { 'int16', 149 },
        ['onSetWeather'] = { 'int8', 152 },
        ['onSetPlayerSkin'] = { 'int32', 'int32', 153 },
        ['onSetInterior'] = { 'int8', 156 },
        ['onSetCameraPosition'] = { 'vector3d', 157 },
        ['onSetCameraLookAt'] = { 'vector3d', 'int8', 158 },
        ['onSetVehiclePosition'] = { 'int16', 'vector3d', 159 },
        ['onSetVehicleAngle'] = { 'int16', 'float', 160 },
        ['onSetVehicleParams'] = { 'int16', 'int16', 'bool8', 161 },
        --['onSetCameraBehind'] = { 162 },
        ['onChatMessage'] = { 'int16', 'string8', 101 },
        ['onConnectionRejected'] = { 'int8', 130 },
        ['onPlayerStreamOut'] = { 'int16', 163 },
        ['onVehicleStreamIn'] = { 164 },
        ['onVehicleStreamOut'] = { 'int16', 165 },
        ['onPlayerDeath'] = { 'int16', 166 },
        ['onPlayerEnterVehicle'] = { 'int16', 'int16', 'bool8', 26 },
        ['onUpdateScoresAndPings'] = { 'PlayerScorePingMap', 155 },
        ['onSetObjectMaterial'] = { 84 },
        ['onSetObjectMaterialText'] = { 84 },
        ['onSetVehicleParamsEx'] = { 'int16', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 'int8', 24 },
        ['onSetPlayerAttachedObject'] = { 'int16', 'int32', 'bool', 'int32', 'int32', 'vector3d', 'vector3d', 'vector3d', 'int32', 'int32', 113 }

    }
    local handler_hook = {
        ['onInitGame'] = true,
        ['onCreateObject'] = true,
        ['onInitMenu'] = true,
        ['onShowTextDraw'] = true,
        ['onVehicleStreamIn'] = true,
        ['onSetObjectMaterial'] = true,
        ['onSetObjectMaterialText'] = true
    }
    local extra = {
        ['PlayerScorePingMap'] = true,
        ['Int32Array3'] = true
    }
    local hook_table = hooks[hook]
    if hook_table then
        local bs = raknetNewBitStream()
        if not handler_hook[hook] then
            local max = #hook_table-1
            if max > 0 then
                for i = 1, max do
                    local p = hook_table[i]
                    if extra[p] then extra_types[p]['write'](bs, parameters[i])
                    else bs_io[p]['write'](bs, parameters[i]) end
                end
            end
        else
            if hook == 'onInitGame' then handler.on_init_game_writer(bs, parameters)
            elseif hook == 'onCreateObject' then handler.on_create_object_writer(bs, parameters)
            elseif hook == 'onInitMenu' then handler.on_init_menu_writer(bs, parameters)
            elseif hook == 'onShowTextDraw' then handler.on_show_textdraw_writer(bs, parameters)
            elseif hook == 'onVehicleStreamIn' then handler.on_vehicle_stream_in_writer(bs, parameters)
            elseif hook == 'onSetObjectMaterial' then handler.on_set_object_material_writer(bs, parameters, 1)
            elseif hook == 'onSetObjectMaterialText' then handler.on_set_object_material_writer(bs, parameters, 2) end
        end
        raknetEmulRpcReceiveBitStream(hook_table[#hook_table], bs)
        raknetDeleteBitStream(bs)
    end
end

--
--     _   _   _ _____ ___  _   _ ____  ____    _  _____ _____   ______   __   ___  ____  _     _  __
--    / \ | | | |_   _/ _ \| | | |  _ \|  _ \  / \|_   _| ____| | __ ) \ / /  / _ \|  _ \| |   | |/ /
--   / _ \| | | | | || | | | | | | |_) | | | |/ _ \ | | |  _|   |  _ \\ V /  | | | | |_) | |   | ' /
--  / ___ \ |_| | | || |_| | |_| |  __/| |_| / ___ \| | | |___  | |_) || |   | |_| |  _ <| |___| . \
-- /_/   \_\___/  |_| \___/ \___/|_|   |____/_/   \_\_| |_____| |____/ |_|    \__\_\_| \_\_____|_|\_\                                                                                                                                                                                                                  
--
-- Author: http://qrlk.me/samp
--
function autoupdate(json_url, prefix, url)
	local dlstatus = require('moonloader').download_status
	local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
	if doesFileExist(json) then os.remove(json) end
	downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
				notf.addNotification("Обнаружено обновление. Пытаюсь обновиться!", 4, 2)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      notf.addNotification("Загрузка обновления завершена!", 4, 2)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
						notf.addNotification("Обновление прошло неудачно. Запускаю устаревшую версию.", 4, 2)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
            end
          end
        else
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end