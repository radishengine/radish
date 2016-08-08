
local ffi = require 'ffi'
local lfs = require 'lfs'

local CHUNK_SIZE = 32 * 1024

local function fcopy(from_f, to_f)
	while true do
		local chunk = from_f:read(CHUNK_SIZE) or ''
		to_f:write(chunk)
		if #chunk < CHUNK_SIZE then
			break
		end
	end
end

compile = {}
setmetatable(compile, compile)

local currentdir = lfs.currentdir()

compile[1] = function(out_f)
	local in_f = assert(io.open(currentdir..'/skeleton.exe', 'rb'))
	fcopy(in_f, out_f)
	in_f:close()
end

local function todata(v)
	local buf = {}
	local loopcheck = {}
	local function add(v)
		local t = type(v)
		if t == 'number' or t == 'boolean' then
			buf[#buf+1] = tostring(v)
		elseif t == 'string' then
			buf[#buf+1] = string.format('%q', v)
		elseif t == 'table' then
			if loopcheck[v] then
				error('cannot encode nested table loop!', 2)
			end
			loopcheck[v] = true
			buf[#buf+1] = '{'
			for k,v in pairs(v) do
				buf[#buf+1] = '['
				add(k)
				buf[#buf+1] = ']='
				add(v)
				buf[#buf+1] = ';'
			end
			buf[#buf+1] = '}'
			loopcheck[v] = nil
		else
			error('cannot encode ' .. t .. ' value', 2)
		end
	end
	add(v)
	local enc = 'return ' .. table.concat(buf)
	-- enc = string.dump(loadstring(enc))
	return enc
end

function compile.include(path)
	local chit = {}
	compile[#compile+1] = function(out_f)
		chit.offset = out_f:seek('cur')
		local in_f = assert(io.open(path, 'rb'))
		chit.length = in_f:seek('end', 0)
		in_f:seek('set', 0)
		fcopy(in_f, out_f)
		in_f:close()
	end
	return chit
end

function compile.include_lib(path)
	local descriptors = {}
	local function include_lib(path, prefix)
		prefix = prefix or ''
		for entry in lfs.dir(path) do
			entry = entry:lower()
			if lfs.attributes(path..'/'..entry, 'mode') == 'directory' then
				if entry ~= '.' and entry ~= '..' then
					include_lib(path..'/'..entry, prefix..entry..'.')
				end
			else
				local submodule_name = entry:match('^(.+)%.lua$')
				if submodule_name then
					local module_name = (prefix .. submodule_name):gsub('%.init$', '')
					descriptors[module_name] = compile.include(path..'/'..entry)
				end
			end
		end
	end
	include_lib(path, '')
	return descriptors
end

function compile.include_data(path)
	local descriptors = {}
	local function include_data(path, prefix)
		prefix = prefix or ''
		for entry in lfs.dir(path) do
			entry = entry:lower()
			if lfs.attributes(path..'/'..entry, 'mode') == 'directory' then
				if entry ~= '.' and entry ~= '..' then
					include_lib(path..'/'..entry, prefix..entry..'/')
				end
			else
				descriptors[entry] = compile.include(path..'/'..entry)
			end
		end
	end
	include_data(path, '')
	return descriptors
end

function compile.data(v)
	local chit = {}
	compile[#compile+1] = function(out_f)
		local encoded = todata(v)
		chit.offset = out_f:seek('cur')
		chit.length = #encoded
		out_f:write(encoded)
	end
	return chit
end

function compile:__call(v)
	if type(v) == 'string' then
		return compile.include(v)
	else
		return compile.data(v)
	end
end

function compile.suffix(v)
	compile.suffix_chit = compile(v)
end

local restore_dir = assert(lfs.currentdir())
assert(lfs.chdir '..')
dofile 'compile_time.lua'

local out_path = 'RELEASE'

if lfs.attributes(out_path, 'mode') ~= 'directory' then
	lfs.mkdir(out_path)
end

local out_f = assert(io.open(out_path .. '/build.exe', 'wb'))
	
for i, step in ipairs(compile) do
	step(out_f)
end

if compile.suffix_chit then
	out_f:write 'RDSH'
	local offset_length = ffi.new('int32_t[2]', compile.suffix_chit.offset, compile.suffix_chit.length)
	out_f:write(ffi.string(offset_length, ffi.sizeof(offset_length)))
end

out_f:close()

assert(lfs.chdir(restore_dir))
