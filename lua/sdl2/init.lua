
local bit = require 'bit'
local ffi = require 'ffi'

local exports = require 'sdl2.exports'

local sdl2 = {}
sdl2.exports = exports

assert(exports.SDL_Init(exports.SDL_INIT_EVERYTHING) >= 0, 'SDL init error')

do -- event stuff

	function sdl2.dispatch(target, totypecode)
		local dispatch = {}
		if target == nil then
			function dispatch:__call(event)
				local typecode, subevent = totypecode(event)		
				local handler = self[typecode]
				if handler ~= nil then
					handler(subevent)
				end
			end
		else
			function dispatch:__call(event)
				local typecode, subevent = totypecode(event)		
				local handler = self[typecode]
				if handler ~= nil then
					handler(target, subevent)
				end
			end
		end
		setmetatable(dispatch, dispatch)
		return dispatch
	end

	sdl2.event = ffi.metatype('SDL_Event', {
		__index = {
			Poll = exports.SDL_PollEvent;
			Wait = exports.SDL_WaitEvent;
			WaitEventTimeout = exports.SDL_WaitEventTimeout;
			Push = exports.SDL_PushEvent;
			GetWindow = function(self)
				if self.common_window.windowID == 0
				or self.type < exports.SDL_WINDOWEVENT
				or self.type == exports.SDL_SYSWMEVENT
				or(self.type >= exports.SDL_JOYAXISMOTION and self.type < exports.SDL_USEREVENT)
				then
					return nil
				end
				return sdl2.windows[self.common_window.windowID]
			end;
			SetUserType = function(self, name)
				self.type = sdl2.user_events[name].typecode
				return self
			end;
		};
	})

	sdl2.main_dispatch = sdl2.dispatch(
		nil,
		function(event)
			return event.type, event
		end)

	sdl2.window_event_codes = {
		exports.SDL_WINDOWEVENT;
		exports.SDL_KEYDOWN;
		exports.SDL_KEYUP;
		exports.SDL_TEXTEDITING;
		exports.SDL_TEXTINPUT;
		exports.SDL_MOUSEMOTION;
		exports.SDL_MOUSEBUTTONDOWN;
		exports.SDL_MOUSEBUTTONUP;
		exports.SDL_MOUSEWHEEL;
	}

	local function pass_event_to_window(event)
		local window = sdl2.windows[event.common_window.windowID]
		if window ~= nil then
			window:MainDispatch(event)
		end
	end

	for _, evcode in ipairs(sdl2.window_event_codes) do
		sdl2.main_dispatch[evcode] = pass_event_to_window
	end

	sdl2.user_events = setmetatable({}, {
		__index = function(self, name)
			local dispatch = sdl2.dispatch()
			self[name] = dispatch
			dispatch.typecode = exports.SDL_RegisterEvents(1)
			sdl2.main_dispatch[dispatch.typecode] = function(event)
				local window = event:GetWindow()
				if window == nil then
					dispatch(event)
				else
					window:MainDispatch(event)
				end
			end
			return dispatch
		end;
	})

	function sdl2.event_loop()
		local e = sdl2.event()
		while true do
			local result = e:Wait()
			if result == 0 then
				-- an error occurred
				break
			end
			if e.type == exports.SDL_QUIT then
				break
			end
			sdl2.main_dispatch(e)
		end
	end

end

do -- window stuff

	sdl2.window = ffi.metatype('SDL_Window', {
		__new = function(self, def)
			assert(type(def) == 'table', 'arg error: expecting window definition table')
			local window = exports.SDL_CreateWindow(
				def.title or 'Running',
				def.x or exports.SDL_WINDOWPOS_UNDEFINED,
				def.y or exports.SDL_WINDOWPOS_UNDEFINED,
				assert(tonumber(def.width or def.w), 'width must be defined'),
				assert(tonumber(def.height or def.h), 'height must be defined'),
				bit.bor(
					def.fullscreen and exports.SDL_WINDOW_FULLSCREEN or 0,
					def.opengl and exports.SDL_WINDOW_OPENGL or 0,
					def.shown and exports.SDL_WINDOW_SHOWN or 0,
					def.hidden and exports.SDL_WINDOW_HIDDEN or 0,
					def.borderless and exports.SDL_WINDOW_BORDERLESS or 0,
					(def.resizable or def.resizeable) and exports.SDL_WINDOW_RESIZABLE or 0,
					def.minimized and exports.SDL_WINDOW_MINIMIZED or 0,
					def.maximized and exports.SDL_WINDOW_MAXIMIZED or 0,
					def.inputgrabbed and exports.SDL_WINDOW_INPUT_GRABBED or 0,
					def.inputfocus and exports.SDL_WINDOW_INPUT_FOCUS or 0,
					def.mousefocus and exports.SDL_WINDOW_MOUSE_FOCUS or 0,
					def.fullscreendesktop and exports.SDL_WINDOW_FULLSCREEN_DESKTOP or 0,
					def.foreign and exports.SDL_WINDOW_FOREIGN or 0,
					def.allowhighdpi and exports.SDL_WINDOW_ALLOW_HIGHDPI or 0,
					def.mousecapture and exports.SDL_WINDOW_MOUSE_CAPTURE or 0
				)
			)
			sdl2.windows[window:GetID()] = window
			return window
		end;
		__index = {
			GetID = exports.SDL_GetWindowID;
			GetFlags = exports.SDL_GetWindowFlags;
			SetTitle = exports.SDL_SetWindowTitle;
			GetTitle = function(self)
				local title = exports.SDL_GetWindowTitle(self)
				if title ~= nil then
					title = ffi.string(title)
				end
				return title
			end;
			Show = exports.SDL_ShowWindow;
			Hide = exports.SDL_HideWindow;
			Destroy = function(self)
				local id = self:GetID()
				sdl2.windows[id] = nil
				sdl2.window_main_dispatch[id] = nil
				sdl2.window_frame_dispatch[id] = nil
				exports.SDL_DestroyWindow(self)
			end;
			MainDispatch = function(self, event)
				return sdl2.window_main_dispatch[self:GetID()](event)
			end;
			FrameDispatch = function(self, event)
				return sdl2.window_frame_dispatch[self:GetID()](event)
			end;
			OnMainEvent = function(self, eventcode, handler)
				sdl2.window_main_dispatch[self:GetID()][eventcode] = handler
			end;
			OnFrameEvent = function(self, eventcode, handler)
				sdl2.window_frame_dispatch[self:GetID()][eventcode] = handler
			end;
			GetHandlers = function(self)
				local id = self:GetID()
				local handlers = sdl2.windowhandlers[id]
				if handlers == nil then
					local window = self
					handlers = {
						__call = function(self, event)
							local handler = self[event.type]
							if handler ~= nil then
								handler(window, event)
							end
						end;
					}
					setmetatable(handlers, handlers)
					sdl2.windowhandlers[id] = handlers
				end
				return handlers
			end;
			HandleEvent = function(self, event)
				self:GetHandlers()(event)
			end;
			CreateRenderer = exports.SDL_CreateRenderer;
		};
	})

	sdl2.windows = setmetatable({}, {
		__index = function(self, id)
			if type(id) ~= 'number' then
				return nil
			end
			local window = exports.SDL_GetWindowFromID(id)
			if window == nil then
				return nil
			end
			self[id] = window
			return window
		end;
	})

	function sdl2.window2dispatch_factory(def)
		return setmetatable({}, {
			__index = function(self, id)
				local window = sdl2.windows[id]
				if window == nil then
					return nil
				end
				local dispatch = sdl2.dispatch(window, def.totypecode)
				for k,v in pairs(def.defaults or {}) do
					dispatch[k] = v
				end
				self[id] = dispatch
				return dispatch
			end;
		})
	end

	sdl2.window_main_dispatch = sdl2.window2dispatch_factory {
		totypecode = function(event)
			return event.type, event
		end;
		defaults = {
			[exports.SDL_WINDOWEVENT] = function(window, event)
				return window:FrameDispatch(event)
			end;
		};
	}

	sdl2.window_frame_dispatch = sdl2.window2dispatch_factory {
		totypecode = function(event)
			return event.window.event, event
		end;
	}

end

do -- surface
	sdl2.surface = ffi.metatype('SDL_Surface', {
		__index = {
			MUSTLOCK = function(self)
				return bit.band(self.flags, exports.SDL_RLEACCEL) ~= 0
			end;
		};
	})
end

do -- renderer

	sdl2.renderer = ffi.metatype('SDL_Renderer', {
		__index = {
			Clear = exports.SDL_RenderClear;
			Copy = exports.SDL_RenderCopy;
			Present = exports.SDL_RenderPresent;
			CreateTextureFromSurface = exports.SDL_CreateTextureFromSurface;
		};
	})

end

do -- rect

	sdl2.rect = ffi.metatype('SDL_Rect', {
		__index = {

		};
	})

end

return sdl2
