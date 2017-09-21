local socket = require("socket")
local udp = socket.udp()
udp:settimeout(0)
udp:setsockname("*", 45595)

local users = {
	
}

while true do
    local data, msg_or_ip, port_or_nil = udp:receivefrom()
    if data then
    		if users[msg_or_ip] == nil then
    			users[msg_or_ip] = {
                ip = msg_or_ip,
    			port = port_or_nil,
    		}
    		end

        print("Received " .. data .. " From " .. msg_or_ip .. ":" .. port_or_nil)

        for k,v in pairs(users) do
        	if k == msg_or_ip then
        	else
        		udp:sendto(tostring(users[k].ip).. ": " .. data, tostring(users[k].ip), tostring(users[k].port))
        		print("Sent " .. data .. " To " .. tostring(users[k].ip) .. ":" .. tostring(users[k].port))
        end

    end
    elseif msg_or_ip ~= "timeout" then
        error("Unknown network error: "..tostring(data))
    end
    socket.sleep(0.1)
end