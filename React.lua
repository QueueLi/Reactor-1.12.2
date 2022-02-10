

local image = require("image")
local buffer = require("doubleBuffering")
local shell = require("shell")
local event = require("event")
local consoleLines = {}
	local function drawStatic()
		buffer.setResolution(85, 30)
		buffer.clear(0xdcdcdc)
		
		buffer.drawRectangle(3, 2, 81, 26, 0xFFFFFF, 0, " ")
		buffer.drawRectangle(61, 1, 2, 32, 0xdcdcdc, 0, " ")
		buffer.drawText(20, 1, 0, "Ядерный реактор")
		buffer.drawRectangle(4, 3, 56, 19, 0xBFBFBF, 0, " ") -- Фон реактора
		
		x = 6 
		y = 4
		for i = 1, 6 do	
		buffer.drawRectangle(x, y, 4, 2, 0xffc6c6, 0, " ") -- вывести	
			for j = 1, 9 do
			buffer.drawRectangle(x, y, 4, 2, 0xffc6c6, 0, " ") -- вывести
			x = x + 6
			end
		x = 6
		y = y + 3
		end
		
		buffer.drawRectangle(18, 23, 28, 3, 0xffc6c6, 0, " ") -- Аварийная кнопка завершения
		buffer.drawText(20, 24, 0, 'Аварийное завершение!')
		

		buffer.drawChanges()
	end

	local function drawRightMenu()
		buffer.drawRectangle(63, 2, 21, 12, 0, 0, " ")
		buffer.drawText(63, 2, 0xAAAAAA, "Вывод:")
		for i = 1, #consoleLines do
			buffer.drawText(63, 2 + i, (15 - #consoleLines + i) * 0x111111, consoleLines[i])
		end
		buffer.drawRectangle(63, 16, 21, 6, 0xFFFFFF, 0, " ")
		for i = 1, 6 do
			if bet == 7 - i then
				buffer.drawRectangle(63, 15 + i, 21, 1, 0xFF8A00, 0, " ")
			end
			buffer.drawText(73, 15 + i, 0, tostring(7 - i)) -- Вывод числа как цифры
		end
		buffer.drawChanges()
	end
	
	local function message(msg)
		table.remove(consoleLines, 1)
		table.insert(consoleLines, tostring(msg))
		drawRightMenu()
	end
	
	local function drawRightMenu()
		buffer.drawRectangle(63, 2, 21, 12, 0, 0, " ")
		buffer.drawText(63, 2, 0xAAAAAA, "Вывод:")
		for i = 1, #consoleLines do
			buffer.drawText(63, 2 + i, (15 - #consoleLines + i) * 0x111111, consoleLines[i])
		end
		buffer.drawRectangle(63, 16, 21, 6, 0xFFFFFF, 0, " ")   
		buffer.drawChanges()
	end

	for i = 1, 11 do
		consoleLines[i] = ""
	end
	
	--Reactor
local offReac = 8400 --температура перегрева реактора до отключения
local perDamage = 76 --процент износа конденсатора при котором он меняется
local com = require("component")
local computer = require("computer")
local gpu = com.gpu
local w,h = gpu.getResolution()
local per,noFuel,lowEu,toReac,run = 0,0,0,1,true
local sideReac,sideInv,sideRed,OutputEUt,StartEUt
local slotReac,Reflector = {},{}
local tr = com.transposer
local reactor = com.reactor_chamber 
	
	if tonumber(string.format('%d%d%d',_OSVERSION:match("(%d).(%d).(%d)"))) < 172 then
	  print("обнаружен ".._OSVERSION.."\n".."требуется версия 1.7 +")
	  os.exit()
	end
 
	if not com.isAvailable("transposer") then
	  print("нет транспозера")
	  os.exit()
	end

	if not com.isAvailable("redstone") then
	  print("нет контроллера красного камня, а он и не нужен, Спасибо supernovus!")
	end

		if not com.isAvailable("reactor_chamber") then
		  print("камера реактора не найдена")
		  os.exit()
		  end
		  
     print("\n".."Проверка реактора на производство Eu !")
	 
	 if reactor.producesEnergy() then
	  print("\n".."Останавливаю реактор!")
	  com.reactor_chamber.stopReactor()	
	end
  print("\n".."Все четко. Продолжаем !")
if reactor.getHeat() > offReac then
  print("\n".."перегрев реактора! Рисковать будем? Y/N") -- Надо нарисовать будет
  os.exit()
end
 
print("поиск реактора и сундука")
for i = 0,5 do
  local vr = tr.getInventoryName(i)
  if vr then
    if string.find(vr,"ic2:te") then
      print("реактор в стороне: "..i)
      sideReac = i
    end
    if string.find(vr,"hest") then
      print("сундук в стороне:  "..i)
      sideInv = i
    end
  end
end
if not sideReac then
  print("\n".."камера реактора не найдена")
  os.exit()
end
if not sideInv then
  print("\n".."сундук не найден")
  os.exit()
end
local slotsReac = tr.getInventorySize(sideReac)
local slotsInv = tr.getInventorySize(sideInv)
 
print("сохранение конденсаторов")
local data = tr.getAllStacks(sideReac).getAll()
for i = 0,slotsReac do
  if data[i] and data[i].name then
    if string.find(data[i].name,"ondensator") then
      local per = math.ceil(100*data[i].damage/data[i].maxDamage)
      print("слот: "..(i).."  износ: "..per.." %")
      if per >= perDamage then
        print("\n".."замените конденсатор в слоте: "..(i))
        os.exit()
      end
      table.insert(slotReac, i)
    end
  end
end
print("сохранение отражателей")
for i = 0,slotsReac do
  if data[i] and data[i].name then
    if string.find(data[i].name,"eflector") then
      print("слот: "..(i))
      table.insert(Reflector, i)
    end
  end
end
 
print("пробный запуск")
for k,n in pairs({3,2,4,5,0,1}) do
  --red.setOutput(n, 15) Включить реатор через редсттоун
  com.reactor_chamber.startReactor()
  if reactor.producesEnergy() then
    os.sleep(1)
    StartEUt = math.ceil(reactor.getReactorEUOutput())
    print("StartEUt = "..StartEUt)
    sideRed = n
    --red.setOutput(n, 0) Выключить реатор через редстоун
    --print("редстоун в стороне: "..sideRed) 
	com.reactor_chamber.stopReactor()
    break
  else
    --red.setOutput(n, 0) Выключить реатор через редстоун
	com.reactor_chamber.stopReactor()
  end
  if k == 6 then
    print("\n".."реактор не запускается")
    os.exit()
  end
end
computer.beep(500, 1)
os.sleep(1)
computer.beep(500, 1)
print("настройка завершена".."\n".."старт...")
os.sleep(1)	
drawStatic()
drawRightMenu()

local function stop(wait) 
  local e = ({event.pull(wait,"key_down")})[4]
  if e == 18 or e == 20 then
	com.reactor_chamber.stopReactor()
    
    message("программа завершена")
    os.sleep(1)
    if reactor.producesEnergy() then
      message("ВНИМАНИЕ реактор по прежнему активен !!!")
    else
      message("реактор остановлен")
    end
    run = false
  end
end


 
local function alert(message) 
  computer.beep(500, 1)
  stop(3)
end

local function ReactorControl()
  local data = tr.getAllStacks(sideReac).getAll()
  for i = 1,#slotReac do
    if data[slotReac[i]].name == "minecraft:air" then
      per = nil
    elseif data[slotReac[i]].damage then
      per = math.ceil(100*data[slotReac[i]].damage/data[slotReac[i]].maxDamage)
      gpu.setForeground(0xFF9900)
      gpu.set(tonumber(xy[slotReac[i]][1]),tonumber(xy[slotReac[i]][2]),tostring(per))
    end
    if per >= 91 then
      --red.setOutput(sideRed, 0)
	  com.reactor_chamber.stoptReactor()
      alert(" снизте % замены конденсат. ")
      while run do
        computer.beep(500, 1)
        stop(3)
      end
      alert(" Выкл системы ")
    end
    if not per or per >= perDamage then
      gpu.setForeground(0xFF9900)
      gpu.set(1,15,"    замена конденсаторов    ")
	  
      if reactor.producesEnergy() then
        --red.setOutput(sideRed, 0)
		com.reactor_chamber.stopReactor()
        os.sleep(0.5)
      end
	  
      tr.transferItem(sideReac, sideInv, 1, slotReac[i])
      gpu.setForeground(0xFF0000)
      gpu.set(tonumber(xy[slotReac[i]][1]),tonumber(xy[slotReac[i]][2]),"██")
      local data1 = tr.getAllStacks(sideInv).getAll()
      for i1 = 0,slotsInv do
        if data1[i1] and data1[i1].name then
          local per = math.ceil(100*data1[i1].damage/data1[i1].maxDamage)
          if string.find(data1[i1].name,"ondensator") and per < 90 then
            toReac = tr.transferItem(sideInv, sideReac, 1, i1, slotReac[i])
            gpu.setForeground(0x00FF00)
            gpu.set(tonumber(xy[slotReac[i]][1]),tonumber(xy[slotReac[i]][2]),"██")
            break
          else
            toReac = 0
          end
        end
      end
    end
  end
  local function circuitCheck() 
    local data = tr.getAllStacks(sideReac).getAll()
    for i = 1,#slotReac do
      if data[slotReac[i]].name == "minecraft:air" then
        return false
      end
    end
    return true
  end
  if reactor.getHeat() > offReac then
    --red.setOutput(sideRed, 0)
	com.reactor_chamber.stopReactor()
    alert("     перегрев реактора !    ")
  elseif not circuitCheck() then
    alert(" нет целых конденсаторов !  ")
  elseif toReac == 0 then
    alert("    в сундуке нет места !   ")
  elseif noFuel >= 5 then
    alert("       нет топлива !        ")
  else
   -- red.setOutput(sideRed, 15)
	com.reactor_chamber.startReactor()
    if not reactor.producesEnergy() then
      alert("  реактор не запускается !  ")
    else
      OutputEUt = math.ceil(reactor.getReactorEUOutput())
      gpu.setForeground(0x00FF00)
      gpu.set(1,14,"      eu/t =  "..OutputEUt.."            ")
      gpu.set(1,15,"      реактор активен       ")
    end
  end
  stop(0.7)
  if reactor.producesEnergy() and reactor.getReactorEUOutput() == 0 then
    noFuel = noFuel + 1
  else
    noFuel = 0
    if OutputEUt and OutputEUt < StartEUt then
      lowEu = lowEu + 1
    else
      lowEu = 0
    end
  end
  if noFuel == 3 or lowEu == 3 then
    local data2 = tr.getAllStacks(sideReac).getAll()
    local data3 = tr.getAllStacks(sideInv).getAll()
    for i2 = 0,slotsReac do
      if data2[i2] and data2[i2].name then
        if string.find(data2[i2].name,"depleted") then
          gpu.setForeground(0xFF9900)
          gpu.set(1,15,"      замена стержней       ")
          tr.transferItem(sideReac, sideInv, 1, i2)
          for i3 = 0,slotsInv do
            if data3[i3] and data3[i3].name then
              if string.find(data3[i3].name,"hexadeca") then
                tr.transferItem(sideInv, sideReac, 1, i3, i2)
                break
              end
            end
          end
        end
      end
    end
    StartEUt = math.ceil(reactor.getReactorEUOutput())
    lowEu = 0
    if Reflector and #Reflector > 1 then
      --red.setOutput(sideRed, 0)
	  com.reactor_chamber.stopReactor()
    end
    for i4 = 1,#Reflector do
      if data2[Reflector[i4]].name == "minecraft:air" then
        for i5 = 0,slotsInv do
          if data3[i5] and data3[i5].name then
            if string.find(data3[i5].name,"eflector") then
              gpu.setForeground(0xFF9900)
              gpu.set(1,15,"      замена отражателя     ")
              tr.transferItem(sideInv, sideReac, 1, i5, Reflector[i4])
            end
          end
        end
      end
    end
  end
  if OutputEUt and OutputEUt > StartEUt then
    StartEUt = math.ceil(reactor.getReactorEUOutput())
  end
end
