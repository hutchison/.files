tell application "Tunnelblick"
	connect "IPredator"
	get state of first configuration where name = "IPredator"
	repeat until result = "CONNECTED"
		delay 1
		get state of first configuration where name = "IPredator"
	end repeat
end tell
