
local core = require 'radish.core'
local ffi = require 'ffi'
local sdl2 = require 'sdl2'
local sdl2_image_exports = require 'sdl2.image.exports'
local exe_data = require '<exe>'.data

local visual = {}

local raster_proto = {}
local raster_meta = {__index = raster_proto}

function visual.raster(source)
	local info = assert(exe_data[source], 'data not found')
	local f = assert(io.open(_EXE, 'rb'))
	f:seek('set', info.offset)
	local data = f:read(info.length)
	f:close()
	local rwops = sdl2.exports.SDL_RWFromMem(ffi.cast('void*', data), #data)
	assert(rwops ~= nil, 'unable to make rwops')
	local surface = sdl2_image_exports.IMG_Load_RW(rwops, true)
	data = nil
	assert(surface ~= nil, 'unable to make surface')
	local texture = core.renderer:CreateTextureFromSurface(surface)
	assert(texture ~= nil, 'unable to make texture')
	local raster = setmetatable({surface=surface, texture=texture}, raster_meta)
	return raster
end

local rmask, gmask, bmask, amask
if ffi.abi 'le' then
	rmask, gmask, bmask, amask = 0x000000ff, 0x0000ff00, 0x00ff0000, 0xff000000
else
    rmask, gmask, bmask, amask = 0xff000000, 0x00ff0000, 0x0000ff00, 0x000000ff
end
local temp_1pixel = sdl2.exports.SDL_CreateRGBSurface(0, 1,1, 32, rmask,gmask,bmask,amask)
local temp_alpha = ffi.cast('uint8_t*', temp_1pixel.pixels) + 3
local temp_rect = sdl2.rect(0,0,1,1)

function raster_proto:alphatest(x, y)
	temp_rect.x, temp_rect.y = x, y
	sdl2.exports.SDL_FillRect(temp_1pixel, nil, 0)
	sdl2.exports.SDL_UpperBlit(self.surface, temp_rect, temp_1pixel, nil)
	return temp_alpha[0] / 255
end

return visual
