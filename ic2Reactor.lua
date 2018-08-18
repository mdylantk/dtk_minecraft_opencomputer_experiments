--wip
--note that this do not set primary components
local component=require("component")
local event=require("event")
local sides=require("sides")
local rs=component.redstone
local reactor=component.reactor

--main var
local isRunning=true
local input=""
--local message=""


--othe var
local cSide=sides.north
local timeID=0
local time=0
local maxTime=60
local timeInt=1

--reactor var
local maxTemp = 1000


  

--functions

local function ShutOff()
  rs.setOutput(cSide,0)
  event.cancel(timeID)
  print("reactor is shutting down")
 end

local function Quit()
  isRunning=false
  ShutOff()
  print("Program shutting down")
end

local function ReactorStart()
  time = 1
  timerID=event.time(timeInt,function() Reactor() end,maxTime)
end

local function ReactorCheck()
  time = time + 1
  print("cycle: " .. time .. "/" .. maxTime)
  print("Heat: " .. reactor.getHeat() .. "/" .. maxTemp)
  
  if reactor.getHeat() >= maxTemp then
    print("reactor too hot")
    ShutOff()
  end
  
  if time >= maxTime then
    print("max cycles reached")
    ShutOff()
   end
  
end


local function GetInput(message)
  print(message)
  input=io.read()
end

local function CheckInput()
  if input =="exit" or input=="quit" then
    Quit()
  elseif input=="start" or input=="timer" then
    ReactorStart()
  elseif input=="set max time" or input=="max cycles" then
    GetInput("Input max cycles")
    Input = maxTime
  elseif input=="set max heat" or input=="max temp" then
    GetInput("Input max temp")
    Input = maxTemp
  elseif input=="set cycle rate" or input=="time int" then
    GetInput("Input cycle rate in seconds")
    Input = timeInt
  elseif input=="set redstone side" or input=="rs" then
    GetInput("(interger) Input redstone side")
    Input = maxTemp
  end
 end
 
while isRunning do
  GetInput(" :: ")
  CheckInput()
end
