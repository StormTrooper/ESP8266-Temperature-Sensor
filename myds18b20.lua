-- read temperature with DS18B20
function sendData()
    t=require("ds18b20")
    t.setup(3)
    addrs=t.addrs()

   print(table.getn(addrs))
   
    t1 = t.read(addrs[1],t.C)
    t2 = t.read(addrs[2],t.C)

    print(t1)
    print(t2)
    
    t = nil
    ds18b20 = nil
    package.loaded["ds18b20"]=nil  

    conn=net.createConnection(net.TCP, 0) 
    conn:on("receive", function(conn, payload) print(payload) end)
    conn:connect(80,'192.168.1.202') 
   
   -- conn:send("GET /tank_temp.php&T1="..t1.."."..string.format("%04d", t2).." HTTP/1.1\r\n") 
    conn:send("GET /tank_temp.php?T1="..t1.."&T2=" ..t2.."\r\n") 
   
    
    conn:send("Accept: */*\r\n") 
    conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
    conn:on("sent",function(conn)
                      print("Closing connection")
                      conn:close()
                  end)
    conn:on("disconnection", function(conn)
                                print("Got disconnection...")
  end)
end

tmr.alarm(0, 300000, 1, function() sendData() end )
--tmr.alarm(0, 60000, 1, function() sendData() end )
