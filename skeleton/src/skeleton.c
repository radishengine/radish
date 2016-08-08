
#include <stdio.h>

#ifdef _WIN32
#	include <windows.h>
#	define EXPORT __declspec(dllexport)
#else
#	define EXPORT
#endif

#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

static const char* const init_script =
	"\n"
	"\n" "local static_libs = {}"
	"\n" "for static_lib in (_STATIC_LIBS_LIST or ''):gmatch('[^;]+') do"
	"\n" "  static_libs[static_lib:lower()] = true"
	"\n" "end"
	"\n"
	"\n" "local ffi = require 'ffi'"
	"\n" "local ffi_load, ffi_C = ffi.load, ffi.C"
	"\n" "function ffi.loadorC(name)"
	"\n" "  if type(name) == 'string' and static_libs[name:lower()] then"
	"\n" "    return ffi_C"
	"\n" "  end"
	"\n" "  return ffi_load(name)"
	"\n" "end"
	"\n"
	"\n" "local f = assert(io.open(_EXE, 'rb'))"
	"\n" "local offset_length = ffi.new('int32_t[2]')"
	"\n" "f:seek('end', -(4 + ffi.sizeof(offset_length)))"
	"\n" "assert(f:read(4) == 'RDSH', 'data block not found')"
	"\n" "ffi.copy(offset_length, f:read(ffi.sizeof(offset_length)))"
	"\n" "f:seek('set', offset_length[0])"
	"\n" "local data = f:read(offset_length[1])"
	"\n" "f:close()"
	"\n" "package.loaded['<exe>'] = assert(loadstring(data))()"
	"\n"
	"\n" "function loadregion(region, chunkname)"
	"\n" "  local f = assert(io.open(_EXE, 'rb'))"
	"\n" "  f:seek('set', region.offset)"
	"\n" "  local data = f:read(region.length)"
	"\n" "  f:close()"
	"\n" "  return loadstring(data, chunkname)"
	"\n" "end"
	"\n"
	"\n" "local exe_data = require '<exe>'"
	"\n"
	"\n" "table.insert(package.loaders, 1, function(name)"
	"\n" "  local from_exe_data = exe_data.lib[name:lower()]"
	"\n" "  if from_exe_data ~= nil then"
	"\n" "    return loadregion(from_exe_data, name)"
	"\n" "  end"
	"\n" "  return 'no packed library: ' .. name"
	"\n" "end)"
	"\n"
	"\n" "local begin = assert(loadregion(exe_data.begin, '<begin>'))"
	"\n" "return begin()"
	"\n";

int lua_panic(lua_State* L)
{
	MessageBoxA(NULL, "Error", lua_tostring(L, -1), MB_OK);
	return 0;
}

int lua_get_executable_path(lua_State* L)
{
#ifdef _WIN32
	DWORD max_size = MAX_PATH;
	wchar_t* buffer = (wchar_t*)lua_newuserdata(L, max_size * sizeof(wchar_t));
	wchar_t* full;
	DWORD size = GetModuleFileNameW(NULL, buffer, max_size);
	int length;
	char* final;
	if (size == 0)
	{
		lua_pop(L, 1);
		lua_pushnil(L);
		return 1;
	}
	while (size == max_size)
	{
		max_size = (max_size * 3) / 2;
		lua_pop(L, 1);
		buffer = (wchar_t*)lua_newuserdata(L, max_size * sizeof(wchar_t));
		size = GetModuleFileNameW(NULL, buffer, max_size);
	}
	/*
	full = _wfullpath(NULL, buffer, 0); // 0 should be ignored
	buffer = NULL;
	*/
	length = WideCharToMultiByte(CP_UTF8, 0, buffer, -1, NULL, 0, NULL, NULL);
	final = (char*)malloc(length);
	WideCharToMultiByte(CP_UTF8, 0, buffer, -1, final, length, NULL, NULL);
	lua_pushlstring(L, final, length-1);
	//free(full);
	free(final);
	return 1;
#else
#	error unsupported platform
#endif
}

lua_State* radish_open_lua_state(const char* begin_name)
{
	lua_State* L = luaL_newstate();
	lua_atpanic(L, lua_panic);
	luaL_openlibs(L);

	lua_get_executable_path(L);
	lua_setglobal(L, "_EXE");

#ifdef STATIC_LIBS_LIST
	lua_pushliteral(L, STATIC_LIBS_LIST);
	lua_setglobal(L, "_STATIC_LIBS_LIST");
#endif

	if (0 != luaL_loadstring(L, init_script))
	{
		lua_error(L);
		return NULL;
	}
	lua_pushstring(L, begin_name);
	lua_call(L, 1, 0);
	return L;
}

#if defined(_WIN32) && !defined(CONSOLE_APP)
#pragma comment(linker, "/SUBSYSTEM:windows")
int WINAPI wWinMain(HINSTANCE instance, HINSTANCE prev_instance, wchar_t* command_line, int show_command)
#else
int main(int argc, char** argv)
#endif
{
	lua_State* L = radish_open_lua_state("main.lua");

	if (!L) return -1;

	return 0;
}
