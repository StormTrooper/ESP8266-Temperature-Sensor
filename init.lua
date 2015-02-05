--init.lua
print("Setting up WIFI...")
wifi.setmode(wifi.STATION)
--modify according your wireless router settings
wifi.sta.config("myssid","mypassword")
wifi.sta.connect()
tmr.alarm(1, 1000, 1, function() 
if wifi.sta.getip()== nil then 
print("IP unavaiable, Waiting...") 
else 
tmr.stop(1)
print("Config done, IP is "..wifi.sta.getip())
dofile("myds18b20.lua")
end 
end)