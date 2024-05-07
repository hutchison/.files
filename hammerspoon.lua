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
	{"ctrl", "alt"}, "right",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()

		f.x = f.x + (f.w / 2)
		f.w = f.w / 2

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "left",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()

		f.w = f.w / 2

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "shift"}, "right",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()

		f.x = f.x + f.w

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "shift"}, "left",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()

		f.x = f.x - f.w

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "shift"}, "up",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()

		f.y = f.y - f.h

		win:setFrame(f)
	end
)

hs.hotkey.bind(
	{"ctrl", "shift"}, "down",
	function()
		local win = hs.window.focusedWindow()
		local f = win:frame()

		f.y = f.y + f.h

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
	{"ctrl", "alt"}, "padenter",
	function()
		hs.eventtap.event.newSystemKeyEvent('PLAY', true):post()
		hs.eventtap.event.newSystemKeyEvent('PLAY', false):post()
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad0",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(0)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad1",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(10)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad2",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(20.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad3",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(30.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad4",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(40.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad4",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(40.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad5",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(50.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)


hs.hotkey.bind(
	{"ctrl", "alt"}, "pad6",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(60.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad7",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(70.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad8",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(80.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)

hs.hotkey.bind(
	{"ctrl", "alt"}, "pad9",
	function()
		local audio_dev = hs.audiodevice.defaultOutputDevice()
		hs.audiodevice.defaultOutputDevice():setVolume(90.1)
		hs.alert.show(math.floor(audio_dev:outputVolume()))
	end
)
