local com = require("component")
local computer = require("computer")
local image = require("image")
local buffer = require("doubleBuffering")
local shell = require("shell")
local event = require("event")
local consoleLines = {}
local eut = 0
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
		
		
		
		buffer.drawRectangle(18, 24, 28, 3, 0xFF0000, 0, " ") -- Аварийная кнопка завершения
		buffer.drawText(20, 25, 0, 'Аварийное завершение!')
		
		
		 buffer.drawRectangle(61, 16, 27, 6, 0xFFFFFF, 0, " ")


		buffer.drawChanges()
	end
	local function drawRightMenu()
    buffer.drawRectangle(61, 2, 27, 12, 0, 0, " ")
    buffer.drawText(61, 2, 0xAAAAAA, "Вывод:")
    for i = 1, #consoleLines do
        buffer.drawText(61, 2 + i, (15 - #consoleLines + i) * 0x111111, consoleLines[i])
    end
   
    
    buffer.drawChanges()
end


local function message(msg)
		table.remove(consoleLines, 1)
		table.insert(consoleLines, tostring(msg))
		drawRightMenu()
	end
	
	
	---------
local function start()
	for address, componentType in com.list("react") do 
	component.invoke(address, "startReactor")
	end
	end
local function stop()
	for address, componentType in com.list("react") do 
	component.invoke(address, "stopReactor")
	end
	end
	
	
	
	local function checkRe()
	
	z = 0
for address, componentType in com.list("react")  do
z = z+1
widgets[z][5] = address -- Запись адресса реактора в ячейку
widgets[z][6] = true

			widgets[z][2] = component.invoke(widgets[z][5], "getReactorEUOutput")
			eut = eut + widgets[i][2]
buffer.drawRectangle(widgets[z][3], widgets[z][4], 4, 2, 0x00FF00, 0, " ")
os.sleep(0.1)

end
	while not com.isAvailable("reactor_chamber")  do
		  message("Ошибика! Нет реакторов!")
		  computer.beep(500, 1)
		  os.sleep(3)
		  end		  
		  

			
		
		  

	i=1
	buffer.drawRectangle(61, 19, 27, 3, 0x111111, 0, " ") --Колличество еу в тик
	buffer.drawText(66, 20, 0x00FF00, 'EU/t : '.. eut)
	buffer.drawChanges()
	return 1
	end
	
	
	local function checkMe()
	while not com.isAvailable("me_interface")  do
		  message("Ошбика! Мэ сеть не прогружена")
     	  computer.beep(500, 1)
		  stop()
		  os.sleep(3)
		  end
  		start()
		  return 1
	end
	
	local function checkLaz()
	sizes = com.me_interface.getItemsInNetwork()[1].size
	buffer.drawRectangle(61, 15, 27, 3, 0x111111, 0, " ") --Колличество Лазурита
			buffer.drawText(66, 16, 0x00FF00, 'Лазурит: ' .. sizes)
	while sizes < 10000  do
	stop()
		  message("Ошбика! Лазурита!")
		  message("Ожидание...")
		  computer.beep(500, 1)
		  buffer.drawRectangle(61, 15, 27, 3, 0x111111, 0, " ") --Колличество Лазурита
			buffer.drawText(66, 16, 0x00FF00, 'Лазурит: ' .. sizes)
		  os.sleep(59)
		sizes = com.me_interface.getItemsInNetwork()[1].size  
    end
		  message("Лазулита ОК ...")
			start()
			buffer.drawRectangle(61, 15, 27, 3, 0x111111, 0, " ") --Колличество Лазурита
			buffer.drawText(66, 16, 0x00FF00, 'Лазурит: ' .. sizes)
		  os.sleep(59)
		buffer.drawChanges()		  
		  return 1
	end
	
	
--------------	
drawStatic()
drawRightMenu()
message("Настройка завершена")
os.sleep(0.1)
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
os.sleep(0.1)
end
message("Найдено реакторов: " .. z)







i=1
k = 2
while k ~= 1 do
message("Проверка всех компонетнов")
os.sleep(0.5)
eut = 0
checkRe()
os.sleep(0.5)
checkMe()
os.sleep(0.5)
checkLaz()
os.sleep(0.5) 
message("Успешно, запускаю реакторы")
start()
	while checkRe() == 1 or  checkMe() == 1 or  checkLaz() == 1  do
	message("Все хорошо ... ")
	message(".. ")
	os.sleep(0.5)
eut = 0
checkRe()
os.sleep(0.5)
checkMe()
os.sleep(0.5)
checkLaz()
os.sleep(0.5)
	end
computer.beep(500, 1)
message("Ошибка! Лазурита! ")
stop()
message("Успешно остановил доступные реакторы") 
end


