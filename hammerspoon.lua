hs.hotkey.bind(
	{"ctrl", "alt"}, "delete",
	function()
		hs.reload()
	end
)
hs.alert.show("Config loaded")

hs.hotkey.bind(
	{"ctrl", "alt"}, "J",
	function()
		local win = hs.window.focusedWindow()
		win:moveToScreen(win:screen():next())
		win:maximize()
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "K",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.x
		f.y = max.y
		f.w = max.w
		f.h = max.h

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "up",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.h = f.h / 2

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "down",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.y = f.y + (f.h / 2)
		f.h = f.h / 2

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "H",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.x
		f.y = max.y
		f.w = max.w / 2
		f.h = max.h

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "L",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.x + (max.w / 2)
		f.y = max.y
		f.w = max.w / 2
		f.h = max.h

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "I",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.w / 2
		f.y = max.y
		f.w = max.w / 2
		f.h = max.h / 2

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "U",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.x
		f.y = max.y
		f.w = max.w / 2
		f.h = max.h / 2

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "N",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.x
		f.y = max.h / 2
		f.w = max.w / 2
		f.h = max.h / 2

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "M",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.w / 2
		f.y = max.h / 2
		f.w = max.w / 2
		f.h = max.h / 2

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"cmd", "alt"}, "1",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.x
		f.y = max.y
		f.w = max.w / 3
		f.h = max.h

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"cmd", "alt"}, "2",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.x + (max.w / 3)
		f.y = max.y
		f.w = max.w / 3
		f.h = max.h

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"cmd", "alt"}, "3",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()
		local max = win:screen():frame()

		f.x = max.x + 2*(max.w / 3)
		f.y = max.y
		f.w = max.w / 3
		f.h = max.h

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad+",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		local vol = math.floor(audio_dev:outputVolume()+1.5)
		hs.audiodevice.defaultOutputDevice():setVolume(vol)
		hs.alert.show(vol)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad-",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		local vol = math.ceil(audio_dev:outputVolume()-1.5)
		hs.audiodevice.defaultOutputDevice():setVolume(vol)
		hs.alert.show(vol)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad*",
	function()
		hs.eventtap.event.newSystemKeyEvent('NEXT', true):post()
		hs.eventtap.event.newSystemKeyEvent('NEXT', false):post()
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad/",
	function()
		hs.eventtap.event.newSystemKeyEvent('PREVIOUS', true):post()
		hs.eventtap.event.newSystemKeyEvent('PREVIOUS', false):post()
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "padenter",
	function()
		hs.eventtap.event.newSystemKeyEvent('PLAY', true):post()
		hs.eventtap.event.newSystemKeyEvent('PLAY', false):post()
	end
)
