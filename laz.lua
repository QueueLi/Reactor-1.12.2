local com = require("component")
local term = require("term")
 
if not com.isAvailable("robot") then
  print("только роботы могут использовать эту программу")
  os.exit()
end
local r = require("robot")
 
if not com.isAvailable("crafting") then
  print("нет улучшения верстак")
  os.exit()
end
local craft = com.crafting
 
if not com.isAvailable("inventory_controller") then
  print("нет контроллера инвентаря")
  os.exit()
end
local i_c = com.inventory_controller
 
local chestside,side = {3,1,0} --"front","up","down"
for k,n in pairs(chestside) do
  local chest = i_c.getInventorySize(n)
  if chest then
    side = n
    break
  end
end
if side then
  print("сундук в стороне: "..side)
  os.sleep(1)
else
  print("сундук не найден")
  os.exit()
end
 
if side == 3 then
  drop = function() if r.drop() then return true end end
elseif side == 1 then
  drop = function() if r.dropUp() then return true end end
elseif side == 0 then
  drop = function() if r.dropDown() then return true end end
end
 
local sizeInv = i_c.getInventorySize(side)
local dropCount = 0
local slotConden = {}
 
local function unload(all)
  if all then
    print("выгрузка всего инвентаря")
    for i = 1,r.inventorySize() do
      if r.count(i) > 0 then
        r.select(i)
        drop()
      end
    end
    return
  end
  if drop() then
    print("выгрузка")
    r.setLightColor(0x008000)
    dropCount = dropCount + 1
  else
    print("в сундуке нет места :(")
    r.setLightColor(0xFF0000)
  end
end
 
local function find_bloc()
  for slot = 1,sizeInv do
    local item = i_c.getStackInSlot(side, slot)
    if item then
      for j, name in pairs({"lapis","dye","redstone"}) do
        if string.find(item.name,name) then
          print(name.." в слоте: "..slot)
          i_c.suckFromSlot(side, slot)
          return
        end
      end
    end
  end
  if r.count(1) == 0 then
    print("в сундуке нет блоков для крафта")
    r.setLightColor(0xFF0000)
    return
  end
end
 
local function craft_conden()
  for slot,n in pairs(slotConden) do
    print("крафт слота: "..slot)
    if r.count(2) == 0 then
      r.select(2)
      i_c.suckFromSlot(side, slot, 1)
    end
    r.select(4)
    if r.count(4) > 0 then
      unload()
    end
    while true do
      if r.count(1) == 0 or r.count(2) == 0 then
        return
      end
      if craft.craft() then
        r.setLightColor(0xFF00FF)
        local item = i_c.getStackInInternalSlot(4)
        if item then
          per = math.ceil(100*item.damage/item.maxDamage)
		  print("Крафчу до ")
          if per > 99.999 then
            r.transferTo(2)
          else
            unload()
            break
          end
        end
      else
        print("ошибка крафта :(")
        r.setLightColor(0xFF0000)
        unload(true)
        return
      end
    end
  end
end
 
while true do
  r.setLightColor(0xFFFFFF)
  term.clear()
  if r.count(2) > 0 then
    r.select(2)
    drop()
  end
  if r.count(1) == 0 then
    r.select(1)
    find_bloc()
  else
    for slot = 1,sizeInv do
      local item = i_c.getStackInSlot(side, slot)
      if item and string.find(item.name,"ondensator") then
        per = math.ceil(100*item.damage/item.maxDamage)
        if per > 0.001 then
          print("конденсатор в слоте: "..slot.."  износ: ".. per .. "%")
          slotConden[slot] = slot
        end
      end
    end
    craft_conden()
    slotConden = {}
  end
  print("всего скрафтил конденсаторов: "..dropCount.."\n".."жду 1 секунду...")
  os.sleep(1)
end
