--Контроллер ядерного комплекса РГ  1 к 50 через впрыскиватель
local com = require("component")
local computer = require("computer")
local image = require("image")
local buffer = require("doubleBuffering")
local shell = require("shell")
local event = require("event")
local consoleLines = {}
local eut = 0
local timer = 60
local Plaz = 10000
local sts = true
local widgets = {
{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },
{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },
{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },
{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },
{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },
{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check },{ id,  eu = 0, xt, yt, add, check }
}
for i = 1, 11 do
    consoleLines[i] = ""
end
local function drawStatic()
		buffer.setResolution(90, 30)
		buffer.clear(0xdcdcdc)
buffer.drawRectangle(3, 2, 86, 28, 0xFFFFFF, 0, " ")
buffer.drawText(16, 1, 0, "Контроль ядерного комплекса РГ")
		buffer.drawRectangle(4, 3, 56, 19, 0xBFBFBF, 0, " ") -- Фон реактора
		
		x = 6 
		y = 4
		local i = 1
		local j = 1
		local n = 1
		for i = 1, 6 do
		 
		buffer.drawRectangle(x, y, 4, 2, 0xffc6c6, 0, " ") -- вывести	кнопочки
			for j = 1, 9 do			
			widgets[n][1] = n			
			widgets[n][3] = x
			widgets[n][4] = y
			n = n+1
			buffer.drawRectangle(x, y, 4, 2, 0xffc6c6, 0, " ") -- вывести кнопочки
			x = x + 6
			end
		x = 6
		
		y = y + 3
		end
		
		x=54
		
buffer.drawRectangle(x-6, y-3, 4, 2, 0xBFBFBF, 0, " ") -- Убрать крайние с крайние 53 
buffer.drawRectangle(x, y-3, 4, 2, 0xBFBFBF, 0, " ") -- Убрать крайние с крайние 54	
buffer.drawRectangle(6, y-3, 4, 2, 0xBFBFBF, 0, " ") -- Убрать крайние с крайние 47
buffer.drawRectangle(12, y-3, 4, 2, 0xBFBFBF, 0, " ") -- Убрать крайние с крайние 46
		
		
		buffer.drawRectangle(6, 23, 25, 3, 0xE06666, 0, " ") -- Аварийная кнопка завершения
		buffer.drawText(8, 24, 0, 'Аварийное завершение!')
		buffer.drawRectangle(31, 23, 28, 3, 0x93C47D, 0, " ") -- Кнопка Старта
		buffer.drawText(36, 24, 0, 'Старт') 
		
		buffer.drawRectangle(6, 26, 25, 3, 0xCCCCCC, 0, " ") -- Выход
		buffer.drawText(14, 27, 0, 'Выход')
		
		buffer.drawText(34, 27, 0, 'Статус комлпекса: ') 
		buffer.drawRectangle(53, 26, 6, 3, 0xFF0000, 0, " ") -- Статус
		
		
		
		
		
		
	 buffer.drawRectangle(61, 16, 27, 6, 0xFFFFFF, 0, " ")

		buffer.drawRectangle(60, 23, 29, 4, 0xCCCCCC, 0, " ") -- Порог лазурита

		buffer.drawChanges()
	end
	local function drawRightMenu()
    buffer.drawRectangle(61, 2, 27, 12, 0, 0, " ")
    buffer.drawText(61, 2, 0xAAAAAA, "Вывод:")
    for i = 1, #consoleLines do
        buffer.drawText(61, 2 + i, (15 - #consoleLines + i) * 0x111111, consoleLines[i])
    end
		
		buffer.drawText(66, 24, 0, "Порог лазурита: " .. Plaz)
		buffer.drawRectangle(60, 23, 4, 2, 0xCCCCCC, 0, " ") -- +
		buffer.drawText(60, 23, 0x00FF00, "__|__")
		buffer.drawText(60, 24, 0x00FF00, "  |  ")
		buffer.drawRectangle(60, 25, 4, 2, 0xCCCCCC, 0, " ") -- -
		buffer.drawText(60, 25, 0xFF0000, " ___ ")
    
    buffer.drawChanges()
end


local function message(msg)
		table.remove(consoleLines, 1)
		table.insert(consoleLines, tostring(msg))
		drawRightMenu()
	end
	
	
	---------
local function Click()	
local e, _, left, top, clickType, _ = event.pull(0.1, "touch")
if left == nil then return nil end
if left >= 6 and left <= 30 and top >= 23 and top <= 25 and sts then 
		message("Off sistem!")
		message("Останавливаю реакторы")
		for address, componentType in com.list("react") do 
	com.invoke(address, "stopReactor")
		end
		message("Успешно")
		sts = false
		
	end
	if left >= 31 and left <= 58 and top >= 23 and top <= 25 and not sts  then 
		message("On sistem!")
		sts = true
	end
if left >= 60 and left <= 64 and top >= 23 and top <= 24 then
Plaz = Plaz + 1000
message("Новый порог : ".. Plaz)
end	

if left >= 60 and left <= 64 and top >= 25 and top <= 26 then
Plaz = Plaz - 1000
message("Новый порог : ".. Plaz)
end	

if left >= 6 and left <= 30 and top >= 26 and top <= 28 then 
		message("Off sistem!")
		message("Останавливаю реакторы")
		for address, componentType in com.list("react") do 
		com.invoke(address, "stopReactor")
		end
		message("Успешно")
		buffer.drawRectangle(53, 26, 6, 3, 0xFF0000, 0, " ") -- Статус OFF
		buffer.drawChanges()
		os.exit()
		
		end
	
end

local function wait(n)
	
	local t = 0
	
	while t < n  do
	if  Click() == nil then
		t = t + 0.1
		timer = timer + 0.1
		end
	end
end


local function start()
	for address, componentType in com.list("react") do 
	com.invoke(address, "startReactor")
	end
					buffer.drawRectangle(61, 19, 27, 3, 0x111111, 0, " ") --Колличество еу в тик
					buffer.drawText(66, 20, 0x00FF00, 'EU/t : '.. eut)
					buffer.drawRectangle(53, 26, 6, 3, 0x00FF00, 0, " ") -- Статус ON
					buffer.drawChanges()
					
	end
local function stop()
	for address, componentType in com.list("react") do 
	com.invoke(address, "stopReactor")
	end
					buffer.drawRectangle(61, 19, 27, 3, 0x111111, 0, " ") --Колличество еу в тик
					buffer.drawText(66, 20, 0x00FF00, 'EU/t : '.. eut)
					buffer.drawRectangle(53, 26, 6, 3, 0xFF0000, 0, " ") -- Статус OFF
					buffer.drawChanges()
					
	end
	
					local function checkRe()	
					z = 0
				for address, componentType in com.list("react")  do
				z = z+1
				widgets[z][5] = address -- Запись адресса реактора в ячейку
				widgets[z][6] = true

							widgets[z][2] = com.invoke(widgets[z][5], "getReactorEUOutput")
							eut = eut + widgets[i][2]
				buffer.drawRectangle(widgets[z][3], widgets[z][4], 4, 2, 0x00FF00, 0, " ")
				wait(0.1)

				end
					while not com.isAvailable("reactor_chamber")  do
						  message("Ошибика! Нет реакторов!")
						  computer.beep(500, 1)
						  wait(3)
						  end		  
					i=1
					
					return 1
					end
	
	local function checkMe()
	while not com.isAvailable("me_interface")  do
		  message("Ошбика! Мэ сеть не прогружена")
     	  computer.beep(500, 1)
		  stop()
		  wait(3)
		  end
  		start()
		  return 1
	end
	
	local function checkLaz()
	
	sizes = com.me_interface.getItemsInNetwork()[1].size --me_interface.getItemsInNetwork('minecraft:lapis_block')[1].size
	buffer.drawRectangle(61, 15, 27, 3, 0x111111, 0, " ") --Колличество Лазурита
			buffer.drawText(66, 16, 0x00FF00, 'Лазурит: ' .. sizes)
	while sizes < Plaz  do
	stop()
		  message("Ошбика! Лазурита!")
		  message("Ожидание... 60 сек")
		  computer.beep(500, 1)
		  buffer.drawRectangle(61, 15, 27, 3, 0x111111, 0, " ") --Колличество Лазурита
			buffer.drawText(66, 16, 0x00FF00, 'Лазурит: ' .. sizes)
		  wait(60)
		sizes = com.me_interface.getItemsInNetwork()[1].size  
    end
		  message("Лазурита ОК ...")
			start()
			buffer.drawRectangle(61, 15, 27, 3, 0x111111, 0, " ") --Колличество Лазурита
			buffer.drawText(66, 16, 0x00FF00, 'Лазурит: ' .. sizes)
		 -- wait(59)
		buffer.drawChanges()
	timer = 0		
		  return 1
	end
	
--------------	
drawStatic()
drawRightMenu()
local function rabota()
sts = true
message("Настройка компонентов")
wait(0.1)
drawRightMenu()
		
		
		widgets[47][1] = widgets[52][1] -- поменять местами 48 с 52
		widgets[47][3] = widgets[52][3]
		widgets[47][4] = widgets[52][4]
		
		widgets[46][1] = widgets[51][1] -- поменять местами 47 с 51	
		widgets[46][3] = widgets[51][3]
		widgets[46][4] = widgets[51][4]
		widgets[52][1] = widgets[47][1] -- поменять местами 48 с 52
		widgets[52][3] = widgets[47][3]
		widgets[52][4] = widgets[47][4]
		
		widgets[51][1] = widgets[46][1] -- поменять местами 47 с 51	
		widgets[51][3] = widgets[46][3]
		widgets[51][4] = widgets[46][4]
buffer.drawChanges()
z = 0
for address, componentType in com.list("react")  do
z = z+1
widgets[z][5] = address -- Запись адресса реактора в ячейку
widgets[z][6] = true
buffer.drawRectangle(widgets[z][3], widgets[z][4], 4, 2, 0x00FF00, 0, " ")
wait(0.1)
end
message("Найдено реакторов: " .. z)

i=1
k = 2
while sts do

message("Проверка всех компонетнов")
wait(0.5)
eut = 0
checkRe()
wait(0.5)
checkMe()
wait(0.5)
if timer >= 60 then 
checkLaz()
end

message("Успешно, запускаю реакторы")
start()
	while (checkRe() == 1 or  checkMe() == 1 or  checkLaz() == 1) and sts == true  do
	--message("Все хорошо ... ")
	buffer.drawRectangle(61, 19, 27, 3, 0x111111, 0, " ") --Колличество еу в тик
	buffer.drawText(66, 20, 0x00FF00, 'EU/t : '.. eut)
	buffer.drawChanges()
	
	if sts then
	message("sts = " .. 1)
	else message("sts = " .. 0)
	end
	
	wait(0.5)
eut = 0
checkRe()
wait(0.5)
checkMe()
wait(0.5)
if timer >= 60 then 
checkLaz()
end
end
computer.beep(500, 1)
message("Остановка ")
stop()

eut = 0
while not sts do 
wait(0.1)
if timer >= 60 then 
checkLaz()
end
buffer.drawRectangle(61, 19, 27, 3, 0x111111, 0, " ") --Колличество еу в тик
buffer.drawText(66, 20, 0x00FF00, 'EU/t : '.. eut)
buffer.drawRectangle(53, 26, 6, 3, 0xFF0000, 0, " ") -- Статус OFF
buffer.drawChanges()

end

end
end


if sts then  rabota() end
