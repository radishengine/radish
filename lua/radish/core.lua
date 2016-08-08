
local sdl2 = require 'sdl2'

local core = {}

core.window = sdl2.window {
	width = 640, height = 480;
	title = 'Radish Project';
	hidden = true;
}

core.onmousepos = function() end
core.onleftclick = function() end

core.window:OnMainEvent(sdl2.exports.SDL_MOUSEMOTION, function(window, event)
	core.onmousepos(event.motion.x, event.motion.y, event.motion.xrel, event.motion.yrel)
end)

core.window:OnMainEvent(sdl2.exports.SDL_MOUSEBUTTONDOWN, function(window, event)
	if event.button.button == sdl2.exports.SDL_BUTTON_LEFT then
		core.onleftclick(event.button.x, event.button.y)
	end
end)

function core.draw() end

core.window:OnFrameEvent(sdl2.exports.SDL_WINDOWEVENT_EXPOSED, function(window, event)
	core.draw(core.renderer)
end)

core.renderer = core.window:CreateRenderer(-1, 0)

function core.main()
	core.window:Show()
	sdl2.event_loop()
end

core.cursors = {
	arrow = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_ARROW';
	ibeam = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_IBEAM';
	wait = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_WAIT';
	crosshair = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_CROSSHAIR';
	waitarrow = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_WAITARROW';
	sizenwse = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_SIZENWSE';
	sizenesw = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_SIZENESW';
	sizewe = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_SIZEWE';
	sizens = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_SIZENS';
	sizeall = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_SIZEALL';
	no = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_NO';
	hand = sdl2.exports.SDL_CreateSystemCursor 'SDL_SYSTEM_CURSOR_HAND';
}

function core.setcursor(cursor)
	if type(cursor) == 'string' then
		cursor = core.cursors[cursor]
	end
	sdl2.exports.SDL_SetCursor(cursor)
end

do -- image
	local sdl2img = require 'sdl2.image.exports'

	function core.image(src)
		local surface = sdl2img.IMG_Load(src)
		local texture = core.renderer:CreateTextureFromSurface(surface)
		return {surface=surface, texture=texture}
	end
end

return core
