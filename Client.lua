local socket = require 'socket'

if arg[1] and arg[2] ~= nil then
	 adress, port = arg[1], arg[2]
else 
	 adress, port = "localhost", 45595
end

udp = socket.udp()	
udp:settimeout(0)
udp:setpeername(adress,port)
username = "Can of soup"

udp:send(username .. " Connected")

while true do 
	input = io.read()
	udp:send(input)

	repeat
		data, msg = udp:receive()
		if data then
			print(data)
		end
	until not data

end