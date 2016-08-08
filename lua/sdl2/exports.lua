
local ffi = require 'ffi'

local lib = ffi.load 'SDL2'

ffi.cdef [[

	// bool
	typedef enum {
		SDL_FALSE = 0,
		SDL_TRUE = 1
	} SDL_bool;

	// init
	enum {
		SDL_INIT_TIMER = 0x00000001,
		SDL_INIT_AUDIO = 0x00000010,
		SDL_INIT_VIDEO = 0x00000020,
		SDL_INIT_JOYSTICK = 0x00000200,
		SDL_INIT_HAPTIC = 0x00001000,
		SDL_INIT_GAMECONTROLLER = 0x00002000,
		SDL_INIT_EVENTS = 0x00004000,
		SDL_INIT_EVERYTHING = (
			SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS
			| SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC | SDL_INIT_GAMECONTROLLER)
	};
	int SDL_Init(uint32_t flags);

	// version
	typedef struct SDL_version { uint8_t major, minor, patch; } SDL_version;

	// window
	typedef struct SDL_Window SDL_Window;

	enum {
		SDL_WINDOWPOS_CENTERED = 0x2FFF0000,
		SDL_WINDOWPOS_UNDEFINED = 0x1FFF0000,

	    SDL_WINDOW_FULLSCREEN = 0x00000001,
	    SDL_WINDOW_OPENGL = 0x00000002,
	    SDL_WINDOW_SHOWN = 0x00000004,
	    SDL_WINDOW_HIDDEN = 0x00000008,
	    SDL_WINDOW_BORDERLESS = 0x00000010,
	    SDL_WINDOW_RESIZABLE = 0x00000020,
	    SDL_WINDOW_MINIMIZED = 0x00000040,
	    SDL_WINDOW_MAXIMIZED = 0x00000080,
	    SDL_WINDOW_INPUT_GRABBED = 0x00000100,
	    SDL_WINDOW_INPUT_FOCUS = 0x00000200,
	    SDL_WINDOW_MOUSE_FOCUS = 0x00000400,
	    SDL_WINDOW_FULLSCREEN_DESKTOP = ( SDL_WINDOW_FULLSCREEN | 0x00001000 ),
	    SDL_WINDOW_FOREIGN = 0x00000800,
	    SDL_WINDOW_ALLOW_HIGHDPI = 0x00002000,
	    SDL_WINDOW_MOUSE_CAPTURE = 0x00004000
	};

	typedef enum {
	    SDL_WINDOWEVENT_NONE,
	    SDL_WINDOWEVENT_SHOWN,
	    SDL_WINDOWEVENT_HIDDEN,
	    SDL_WINDOWEVENT_EXPOSED,
	    SDL_WINDOWEVENT_MOVED,
	    SDL_WINDOWEVENT_RESIZED,
	    SDL_WINDOWEVENT_SIZE_CHANGED,
	    SDL_WINDOWEVENT_MINIMIZED,
	    SDL_WINDOWEVENT_MAXIMIZED,
	    SDL_WINDOWEVENT_RESTORED,
	    SDL_WINDOWEVENT_ENTER,
	    SDL_WINDOWEVENT_LEAVE,
	    SDL_WINDOWEVENT_FOCUS_GAINED,
	    SDL_WINDOWEVENT_FOCUS_LOST,
	    SDL_WINDOWEVENT_CLOSE
	} SDL_WindowEventID;

	SDL_Window* SDL_CreateWindow(const char* title, int x, int y, int w, int h, uint32_t flags);
	uint32_t SDL_GetWindowID(SDL_Window*);
	SDL_Window* SDL_GetWindowFromID(uint32_t);
	uint32_t SDL_GetWindowFlags(SDL_Window*);
	void SDL_SetWindowTitle(SDL_Window*, const char *title);
	const char* SDL_GetWindowTitle(SDL_Window*);
	void SDL_ShowWindow(SDL_Window*);
	void SDL_HideWindow(SDL_Window*);
	void SDL_DestroyWindow(SDL_Window*);

	// keyboard
	typedef enum {
		SDL_SCANCODE_UNKNOWN = 0,

		SDL_SCANCODE_A = 4,
		SDL_SCANCODE_B = 5,
		SDL_SCANCODE_C = 6,
		SDL_SCANCODE_D = 7,
		SDL_SCANCODE_E = 8,
		SDL_SCANCODE_F = 9,
		SDL_SCANCODE_G = 10,
		SDL_SCANCODE_H = 11,
		SDL_SCANCODE_I = 12,
		SDL_SCANCODE_J = 13,
		SDL_SCANCODE_K = 14,
		SDL_SCANCODE_L = 15,
		SDL_SCANCODE_M = 16,
		SDL_SCANCODE_N = 17,
		SDL_SCANCODE_O = 18,
		SDL_SCANCODE_P = 19,
		SDL_SCANCODE_Q = 20,
		SDL_SCANCODE_R = 21,
		SDL_SCANCODE_S = 22,
		SDL_SCANCODE_T = 23,
		SDL_SCANCODE_U = 24,
		SDL_SCANCODE_V = 25,
		SDL_SCANCODE_W = 26,
		SDL_SCANCODE_X = 27,
		SDL_SCANCODE_Y = 28,
		SDL_SCANCODE_Z = 29,

		SDL_SCANCODE_1 = 30,
		SDL_SCANCODE_2 = 31,
		SDL_SCANCODE_3 = 32,
		SDL_SCANCODE_4 = 33,
		SDL_SCANCODE_5 = 34,
		SDL_SCANCODE_6 = 35,
		SDL_SCANCODE_7 = 36,
		SDL_SCANCODE_8 = 37,
		SDL_SCANCODE_9 = 38,
		SDL_SCANCODE_0 = 39,

		SDL_SCANCODE_RETURN = 40,
		SDL_SCANCODE_ESCAPE = 41,
		SDL_SCANCODE_BACKSPACE = 42,
		SDL_SCANCODE_TAB = 43,
		SDL_SCANCODE_SPACE = 44,

		SDL_SCANCODE_MINUS = 45,
		SDL_SCANCODE_EQUALS = 46,
		SDL_SCANCODE_LEFTBRACKET = 47,
		SDL_SCANCODE_RIGHTBRACKET = 48,
		SDL_SCANCODE_BACKSLASH = 49, 
		SDL_SCANCODE_NONUSHASH = 50, 
		SDL_SCANCODE_SEMICOLON = 51,
		SDL_SCANCODE_APOSTROPHE = 52,
		SDL_SCANCODE_GRAVE = 53, 
		SDL_SCANCODE_COMMA = 54,
		SDL_SCANCODE_PERIOD = 55,
		SDL_SCANCODE_SLASH = 56,

		SDL_SCANCODE_CAPSLOCK = 57,

		SDL_SCANCODE_F1 = 58,
		SDL_SCANCODE_F2 = 59,
		SDL_SCANCODE_F3 = 60,
		SDL_SCANCODE_F4 = 61,
		SDL_SCANCODE_F5 = 62,
		SDL_SCANCODE_F6 = 63,
		SDL_SCANCODE_F7 = 64,
		SDL_SCANCODE_F8 = 65,
		SDL_SCANCODE_F9 = 66,
		SDL_SCANCODE_F10 = 67,
		SDL_SCANCODE_F11 = 68,
		SDL_SCANCODE_F12 = 69,

		SDL_SCANCODE_PRINTSCREEN = 70,
		SDL_SCANCODE_SCROLLLOCK = 71,
		SDL_SCANCODE_PAUSE = 72,
		SDL_SCANCODE_INSERT = 73, 
		SDL_SCANCODE_HOME = 74,
		SDL_SCANCODE_PAGEUP = 75,
		SDL_SCANCODE_DELETE = 76,
		SDL_SCANCODE_END = 77,
		SDL_SCANCODE_PAGEDOWN = 78,
		SDL_SCANCODE_RIGHT = 79,
		SDL_SCANCODE_LEFT = 80,
		SDL_SCANCODE_DOWN = 81,
		SDL_SCANCODE_UP = 82,

		SDL_SCANCODE_NUMLOCKCLEAR = 83, 
		SDL_SCANCODE_KP_DIVIDE = 84,
		SDL_SCANCODE_KP_MULTIPLY = 85,
		SDL_SCANCODE_KP_MINUS = 86,
		SDL_SCANCODE_KP_PLUS = 87,
		SDL_SCANCODE_KP_ENTER = 88,
		SDL_SCANCODE_KP_1 = 89,
		SDL_SCANCODE_KP_2 = 90,
		SDL_SCANCODE_KP_3 = 91,
		SDL_SCANCODE_KP_4 = 92,
		SDL_SCANCODE_KP_5 = 93,
		SDL_SCANCODE_KP_6 = 94,
		SDL_SCANCODE_KP_7 = 95,
		SDL_SCANCODE_KP_8 = 96,
		SDL_SCANCODE_KP_9 = 97,
		SDL_SCANCODE_KP_0 = 98,
		SDL_SCANCODE_KP_PERIOD = 99,

		SDL_SCANCODE_NONUSBACKSLASH = 100, 
		SDL_SCANCODE_APPLICATION = 101, 
		SDL_SCANCODE_POWER = 102, 
		SDL_SCANCODE_KP_EQUALS = 103,
		SDL_SCANCODE_F13 = 104,
		SDL_SCANCODE_F14 = 105,
		SDL_SCANCODE_F15 = 106,
		SDL_SCANCODE_F16 = 107,
		SDL_SCANCODE_F17 = 108,
		SDL_SCANCODE_F18 = 109,
		SDL_SCANCODE_F19 = 110,
		SDL_SCANCODE_F20 = 111,
		SDL_SCANCODE_F21 = 112,
		SDL_SCANCODE_F22 = 113,
		SDL_SCANCODE_F23 = 114,
		SDL_SCANCODE_F24 = 115,
		SDL_SCANCODE_EXECUTE = 116,
		SDL_SCANCODE_HELP = 117,
		SDL_SCANCODE_MENU = 118,
		SDL_SCANCODE_SELECT = 119,
		SDL_SCANCODE_STOP = 120,
		SDL_SCANCODE_AGAIN = 121,   
		SDL_SCANCODE_UNDO = 122,
		SDL_SCANCODE_CUT = 123,
		SDL_SCANCODE_COPY = 124,
		SDL_SCANCODE_PASTE = 125,
		SDL_SCANCODE_FIND = 126,
		SDL_SCANCODE_MUTE = 127,
		SDL_SCANCODE_VOLUMEUP = 128,
		SDL_SCANCODE_VOLUMEDOWN = 129,
		
		SDL_SCANCODE_KP_COMMA = 133,
		SDL_SCANCODE_KP_EQUALSAS400 = 134,

		SDL_SCANCODE_INTERNATIONAL1 = 135, 
		SDL_SCANCODE_INTERNATIONAL2 = 136,
		SDL_SCANCODE_INTERNATIONAL3 = 137, 
		SDL_SCANCODE_INTERNATIONAL4 = 138,
		SDL_SCANCODE_INTERNATIONAL5 = 139,
		SDL_SCANCODE_INTERNATIONAL6 = 140,
		SDL_SCANCODE_INTERNATIONAL7 = 141,
		SDL_SCANCODE_INTERNATIONAL8 = 142,
		SDL_SCANCODE_INTERNATIONAL9 = 143,
		SDL_SCANCODE_LANG1 = 144, 
		SDL_SCANCODE_LANG2 = 145, 
		SDL_SCANCODE_LANG3 = 146, 
		SDL_SCANCODE_LANG4 = 147, 
		SDL_SCANCODE_LANG5 = 148, 
		SDL_SCANCODE_LANG6 = 149, 
		SDL_SCANCODE_LANG7 = 150, 
		SDL_SCANCODE_LANG8 = 151, 
		SDL_SCANCODE_LANG9 = 152, 

		SDL_SCANCODE_ALTERASE = 153, 
		SDL_SCANCODE_SYSREQ = 154,
		SDL_SCANCODE_CANCEL = 155,
		SDL_SCANCODE_CLEAR = 156,
		SDL_SCANCODE_PRIOR = 157,
		SDL_SCANCODE_RETURN2 = 158,
		SDL_SCANCODE_SEPARATOR = 159,
		SDL_SCANCODE_OUT = 160,
		SDL_SCANCODE_OPER = 161,
		SDL_SCANCODE_CLEARAGAIN = 162,
		SDL_SCANCODE_CRSEL = 163,
		SDL_SCANCODE_EXSEL = 164,

		SDL_SCANCODE_KP_00 = 176,
		SDL_SCANCODE_KP_000 = 177,
		SDL_SCANCODE_THOUSANDSSEPARATOR = 178,
		SDL_SCANCODE_DECIMALSEPARATOR = 179,
		SDL_SCANCODE_CURRENCYUNIT = 180,
		SDL_SCANCODE_CURRENCYSUBUNIT = 181,
		SDL_SCANCODE_KP_LEFTPAREN = 182,
		SDL_SCANCODE_KP_RIGHTPAREN = 183,
		SDL_SCANCODE_KP_LEFTBRACE = 184,
		SDL_SCANCODE_KP_RIGHTBRACE = 185,
		SDL_SCANCODE_KP_TAB = 186,
		SDL_SCANCODE_KP_BACKSPACE = 187,
		SDL_SCANCODE_KP_A = 188,
		SDL_SCANCODE_KP_B = 189,
		SDL_SCANCODE_KP_C = 190,
		SDL_SCANCODE_KP_D = 191,
		SDL_SCANCODE_KP_E = 192,
		SDL_SCANCODE_KP_F = 193,
		SDL_SCANCODE_KP_XOR = 194,
		SDL_SCANCODE_KP_POWER = 195,
		SDL_SCANCODE_KP_PERCENT = 196,
		SDL_SCANCODE_KP_LESS = 197,
		SDL_SCANCODE_KP_GREATER = 198,
		SDL_SCANCODE_KP_AMPERSAND = 199,
		SDL_SCANCODE_KP_DBLAMPERSAND = 200,
		SDL_SCANCODE_KP_VERTICALBAR = 201,
		SDL_SCANCODE_KP_DBLVERTICALBAR = 202,
		SDL_SCANCODE_KP_COLON = 203,
		SDL_SCANCODE_KP_HASH = 204,
		SDL_SCANCODE_KP_SPACE = 205,
		SDL_SCANCODE_KP_AT = 206,
		SDL_SCANCODE_KP_EXCLAM = 207,
		SDL_SCANCODE_KP_MEMSTORE = 208,
		SDL_SCANCODE_KP_MEMRECALL = 209,
		SDL_SCANCODE_KP_MEMCLEAR = 210,
		SDL_SCANCODE_KP_MEMADD = 211,
		SDL_SCANCODE_KP_MEMSUBTRACT = 212,
		SDL_SCANCODE_KP_MEMMULTIPLY = 213,
		SDL_SCANCODE_KP_MEMDIVIDE = 214,
		SDL_SCANCODE_KP_PLUSMINUS = 215,
		SDL_SCANCODE_KP_CLEAR = 216,
		SDL_SCANCODE_KP_CLEARENTRY = 217,
		SDL_SCANCODE_KP_BINARY = 218,
		SDL_SCANCODE_KP_OCTAL = 219,
		SDL_SCANCODE_KP_DECIMAL = 220,
		SDL_SCANCODE_KP_HEXADECIMAL = 221,

		SDL_SCANCODE_LCTRL = 224,
		SDL_SCANCODE_LSHIFT = 225,
		SDL_SCANCODE_LALT = 226, 
		SDL_SCANCODE_LGUI = 227, 
		SDL_SCANCODE_RCTRL = 228,
		SDL_SCANCODE_RSHIFT = 229,
		SDL_SCANCODE_RALT = 230, 
		SDL_SCANCODE_RGUI = 231, 

		SDL_SCANCODE_MODE = 257,    
		SDL_SCANCODE_AUDIONEXT = 258,
		SDL_SCANCODE_AUDIOPREV = 259,
		SDL_SCANCODE_AUDIOSTOP = 260,
		SDL_SCANCODE_AUDIOPLAY = 261,
		SDL_SCANCODE_AUDIOMUTE = 262,
		SDL_SCANCODE_MEDIASELECT = 263,
		SDL_SCANCODE_WWW = 264,
		SDL_SCANCODE_MAIL = 265,
		SDL_SCANCODE_CALCULATOR = 266,
		SDL_SCANCODE_COMPUTER = 267,
		SDL_SCANCODE_AC_SEARCH = 268,
		SDL_SCANCODE_AC_HOME = 269,
		SDL_SCANCODE_AC_BACK = 270,
		SDL_SCANCODE_AC_FORWARD = 271,
		SDL_SCANCODE_AC_STOP = 272,
		SDL_SCANCODE_AC_REFRESH = 273,
		SDL_SCANCODE_AC_BOOKMARKS = 274,
		SDL_SCANCODE_BRIGHTNESSDOWN = 275,
		SDL_SCANCODE_BRIGHTNESSUP = 276,
		SDL_SCANCODE_DISPLAYSWITCH = 277, 
		SDL_SCANCODE_KBDILLUMTOGGLE = 278,
		SDL_SCANCODE_KBDILLUMDOWN = 279,
		SDL_SCANCODE_KBDILLUMUP = 280,
		SDL_SCANCODE_EJECT = 281,
		SDL_SCANCODE_SLEEP = 282,
		SDL_SCANCODE_APP1 = 283,
		SDL_SCANCODE_APP2 = 284,

		SDL_NUM_SCANCODES = 512 
	} SDL_Scancode;

	enum {
		SDLK_UNKNOWN = 0,

		SDLK_RETURN = '\r',
		SDLK_ESCAPE = '\033',
		SDLK_BACKSPACE = '\b',
		SDLK_TAB = '\t',
		SDLK_SPACE = ' ',
		SDLK_EXCLAIM = '!',
		SDLK_QUOTEDBL = '"',
		SDLK_HASH = '#',
		SDLK_PERCENT = '%',
		SDLK_DOLLAR = '$',
		SDLK_AMPERSAND = '&',
		SDLK_QUOTE = '\'',
		SDLK_LEFTPAREN = '(',
		SDLK_RIGHTPAREN = ')',
		SDLK_ASTERISK = '*',
		SDLK_PLUS = '+',
		SDLK_COMMA = ',',
		SDLK_MINUS = '-',
		SDLK_PERIOD = '.',
		SDLK_SLASH = '/',
		SDLK_0 = '0',
		SDLK_1 = '1',
		SDLK_2 = '2',
		SDLK_3 = '3',
		SDLK_4 = '4',
		SDLK_5 = '5',
		SDLK_6 = '6',
		SDLK_7 = '7',
		SDLK_8 = '8',
		SDLK_9 = '9',
		SDLK_COLON = ':',
		SDLK_SEMICOLON = ';',
		SDLK_LESS = '<',
		SDLK_EQUALS = '=',
		SDLK_GREATER = '>',
		SDLK_QUESTION = '?',
		SDLK_AT = '@',
		SDLK_LEFTBRACKET = '[',
		SDLK_BACKSLASH = '\\',
		SDLK_RIGHTBRACKET = ']',
		SDLK_CARET = '^',
		SDLK_UNDERSCORE = '_',
		SDLK_BACKQUOTE = '`',
		SDLK_a = 'a',
		SDLK_b = 'b',
		SDLK_c = 'c',
		SDLK_d = 'd',
		SDLK_e = 'e',
		SDLK_f = 'f',
		SDLK_g = 'g',
		SDLK_h = 'h',
		SDLK_i = 'i',
		SDLK_j = 'j',
		SDLK_k = 'k',
		SDLK_l = 'l',
		SDLK_m = 'm',
		SDLK_n = 'n',
		SDLK_o = 'o',
		SDLK_p = 'p',
		SDLK_q = 'q',
		SDLK_r = 'r',
		SDLK_s = 's',
		SDLK_t = 't',
		SDLK_u = 'u',
		SDLK_v = 'v',
		SDLK_w = 'w',
		SDLK_x = 'x',
		SDLK_y = 'y',
		SDLK_z = 'z',

		SDLK_CAPSLOCK = SDL_SCANCODE_CAPSLOCK | 1<<30,
		SDLK_F1 = SDL_SCANCODE_F1 | 1<<30,
		SDLK_F2 = SDL_SCANCODE_F2 | 1<<30,
		SDLK_F3 = SDL_SCANCODE_F3 | 1<<30,
		SDLK_F4 = SDL_SCANCODE_F4 | 1<<30,
		SDLK_F5 = SDL_SCANCODE_F5 | 1<<30,
		SDLK_F6 = SDL_SCANCODE_F6 | 1<<30,
		SDLK_F7 = SDL_SCANCODE_F7 | 1<<30,
		SDLK_F8 = SDL_SCANCODE_F8 | 1<<30,
		SDLK_F9 = SDL_SCANCODE_F9 | 1<<30,
		SDLK_F10 = SDL_SCANCODE_F10 | 1<<30,
		SDLK_F11 = SDL_SCANCODE_F11 | 1<<30,
		SDLK_F12 = SDL_SCANCODE_F12 | 1<<30,

		SDLK_PRINTSCREEN = SDL_SCANCODE_PRINTSCREEN | 1<<30,
		SDLK_SCROLLLOCK = SDL_SCANCODE_SCROLLLOCK | 1<<30,
		SDLK_PAUSE = SDL_SCANCODE_PAUSE | 1<<30,
		SDLK_INSERT = SDL_SCANCODE_INSERT | 1<<30,
		SDLK_HOME = SDL_SCANCODE_HOME | 1<<30,
		SDLK_PAGEUP = SDL_SCANCODE_PAGEUP | 1<<30,
		SDLK_DELETE = '\177',
		SDLK_END = SDL_SCANCODE_END | 1<<30,
		SDLK_PAGEDOWN = SDL_SCANCODE_PAGEDOWN | 1<<30,
		SDLK_RIGHT = SDL_SCANCODE_RIGHT | 1<<30,
		SDLK_LEFT = SDL_SCANCODE_LEFT | 1<<30,
		SDLK_DOWN = SDL_SCANCODE_DOWN | 1<<30,
		SDLK_UP = SDL_SCANCODE_UP | 1<<30,

		SDLK_NUMLOCKCLEAR = SDL_SCANCODE_NUMLOCKCLEAR | 1<<30,
		SDLK_KP_DIVIDE = SDL_SCANCODE_KP_DIVIDE | 1<<30,
		SDLK_KP_MULTIPLY = SDL_SCANCODE_KP_MULTIPLY | 1<<30,
		SDLK_KP_MINUS = SDL_SCANCODE_KP_MINUS | 1<<30,
		SDLK_KP_PLUS = SDL_SCANCODE_KP_PLUS | 1<<30,
		SDLK_KP_ENTER = SDL_SCANCODE_KP_ENTER | 1<<30,
		SDLK_KP_1 = SDL_SCANCODE_KP_1 | 1<<30,
		SDLK_KP_2 = SDL_SCANCODE_KP_2 | 1<<30,
		SDLK_KP_3 = SDL_SCANCODE_KP_3 | 1<<30,
		SDLK_KP_4 = SDL_SCANCODE_KP_4 | 1<<30,
		SDLK_KP_5 = SDL_SCANCODE_KP_5 | 1<<30,
		SDLK_KP_6 = SDL_SCANCODE_KP_6 | 1<<30,
		SDLK_KP_7 = SDL_SCANCODE_KP_7 | 1<<30,
		SDLK_KP_8 = SDL_SCANCODE_KP_8 | 1<<30,
		SDLK_KP_9 = SDL_SCANCODE_KP_9 | 1<<30,
		SDLK_KP_0 = SDL_SCANCODE_KP_0 | 1<<30,
		SDLK_KP_PERIOD = SDL_SCANCODE_KP_PERIOD | 1<<30,

		SDLK_APPLICATION = SDL_SCANCODE_APPLICATION | 1<<30,
		SDLK_POWER = SDL_SCANCODE_POWER | 1<<30,
		SDLK_KP_EQUALS = SDL_SCANCODE_KP_EQUALS | 1<<30,
		SDLK_F13 = SDL_SCANCODE_F13 | 1<<30,
		SDLK_F14 = SDL_SCANCODE_F14 | 1<<30,
		SDLK_F15 = SDL_SCANCODE_F15 | 1<<30,
		SDLK_F16 = SDL_SCANCODE_F16 | 1<<30,
		SDLK_F17 = SDL_SCANCODE_F17 | 1<<30,
		SDLK_F18 = SDL_SCANCODE_F18 | 1<<30,
		SDLK_F19 = SDL_SCANCODE_F19 | 1<<30,
		SDLK_F20 = SDL_SCANCODE_F20 | 1<<30,
		SDLK_F21 = SDL_SCANCODE_F21 | 1<<30,
		SDLK_F22 = SDL_SCANCODE_F22 | 1<<30,
		SDLK_F23 = SDL_SCANCODE_F23 | 1<<30,
		SDLK_F24 = SDL_SCANCODE_F24 | 1<<30,
		SDLK_EXECUTE = SDL_SCANCODE_EXECUTE | 1<<30,
		SDLK_HELP = SDL_SCANCODE_HELP | 1<<30,
		SDLK_MENU = SDL_SCANCODE_MENU | 1<<30,
		SDLK_SELECT = SDL_SCANCODE_SELECT | 1<<30,
		SDLK_STOP = SDL_SCANCODE_STOP | 1<<30,
		SDLK_AGAIN = SDL_SCANCODE_AGAIN | 1<<30,
		SDLK_UNDO = SDL_SCANCODE_UNDO | 1<<30,
		SDLK_CUT = SDL_SCANCODE_CUT | 1<<30,
		SDLK_COPY = SDL_SCANCODE_COPY | 1<<30,
		SDLK_PASTE = SDL_SCANCODE_PASTE | 1<<30,
		SDLK_FIND = SDL_SCANCODE_FIND | 1<<30,
		SDLK_MUTE = SDL_SCANCODE_MUTE | 1<<30,
		SDLK_VOLUMEUP = SDL_SCANCODE_VOLUMEUP | 1<<30,
		SDLK_VOLUMEDOWN = SDL_SCANCODE_VOLUMEDOWN | 1<<30,
		SDLK_KP_COMMA = SDL_SCANCODE_KP_COMMA | 1<<30,
		SDLK_KP_EQUALSAS400 = SDL_SCANCODE_KP_EQUALSAS400 | 1<<30,
		SDLK_ALTERASE = SDL_SCANCODE_ALTERASE | 1<<30,
		SDLK_SYSREQ = SDL_SCANCODE_SYSREQ | 1<<30,
		SDLK_CANCEL = SDL_SCANCODE_CANCEL | 1<<30,
		SDLK_CLEAR = SDL_SCANCODE_CLEAR | 1<<30,
		SDLK_PRIOR = SDL_SCANCODE_PRIOR | 1<<30,
		SDLK_RETURN2 = SDL_SCANCODE_RETURN2 | 1<<30,
		SDLK_SEPARATOR = SDL_SCANCODE_SEPARATOR | 1<<30,
		SDLK_OUT = SDL_SCANCODE_OUT | 1<<30,
		SDLK_OPER = SDL_SCANCODE_OPER | 1<<30,
		SDLK_CLEARAGAIN = SDL_SCANCODE_CLEARAGAIN | 1<<30,
		SDLK_CRSEL = SDL_SCANCODE_CRSEL | 1<<30,
		SDLK_EXSEL = SDL_SCANCODE_EXSEL | 1<<30,
		SDLK_KP_00 = SDL_SCANCODE_KP_00 | 1<<30,
		SDLK_KP_000 = SDL_SCANCODE_KP_000 | 1<<30,
		SDLK_THOUSANDSSEPARATOR =
		SDL_SCANCODE_THOUSANDSSEPARATOR | 1<<30,
		SDLK_DECIMALSEPARATOR =
		SDL_SCANCODE_DECIMALSEPARATOR | 1<<30,
		SDLK_CURRENCYUNIT = SDL_SCANCODE_CURRENCYUNIT | 1<<30,
		SDLK_CURRENCYSUBUNIT =
		SDL_SCANCODE_CURRENCYSUBUNIT | 1<<30,
		SDLK_KP_LEFTPAREN = SDL_SCANCODE_KP_LEFTPAREN | 1<<30,
		SDLK_KP_RIGHTPAREN = SDL_SCANCODE_KP_RIGHTPAREN | 1<<30,
		SDLK_KP_LEFTBRACE = SDL_SCANCODE_KP_LEFTBRACE | 1<<30,
		SDLK_KP_RIGHTBRACE = SDL_SCANCODE_KP_RIGHTBRACE | 1<<30,
		SDLK_KP_TAB = SDL_SCANCODE_KP_TAB | 1<<30,
		SDLK_KP_BACKSPACE = SDL_SCANCODE_KP_BACKSPACE | 1<<30,
		SDLK_KP_A = SDL_SCANCODE_KP_A | 1<<30,
		SDLK_KP_B = SDL_SCANCODE_KP_B | 1<<30,
		SDLK_KP_C = SDL_SCANCODE_KP_C | 1<<30,
		SDLK_KP_D = SDL_SCANCODE_KP_D | 1<<30,
		SDLK_KP_E = SDL_SCANCODE_KP_E | 1<<30,
		SDLK_KP_F = SDL_SCANCODE_KP_F | 1<<30,
		SDLK_KP_XOR = SDL_SCANCODE_KP_XOR | 1<<30,
		SDLK_KP_POWER = SDL_SCANCODE_KP_POWER | 1<<30,
		SDLK_KP_PERCENT = SDL_SCANCODE_KP_PERCENT | 1<<30,
		SDLK_KP_LESS = SDL_SCANCODE_KP_LESS | 1<<30,
		SDLK_KP_GREATER = SDL_SCANCODE_KP_GREATER | 1<<30,
		SDLK_KP_AMPERSAND = SDL_SCANCODE_KP_AMPERSAND | 1<<30,
		SDLK_KP_DBLAMPERSAND = SDL_SCANCODE_KP_DBLAMPERSAND | 1<<30,
		SDLK_KP_VERTICALBAR = SDL_SCANCODE_KP_VERTICALBAR | 1<<30,
		SDLK_KP_DBLVERTICALBAR = SDL_SCANCODE_KP_DBLVERTICALBAR | 1<<30,
		SDLK_KP_COLON = SDL_SCANCODE_KP_COLON | 1<<30,
		SDLK_KP_HASH = SDL_SCANCODE_KP_HASH | 1<<30,
		SDLK_KP_SPACE = SDL_SCANCODE_KP_SPACE | 1<<30,
		SDLK_KP_AT = SDL_SCANCODE_KP_AT | 1<<30,
		SDLK_KP_EXCLAM = SDL_SCANCODE_KP_EXCLAM | 1<<30,
		SDLK_KP_MEMSTORE = SDL_SCANCODE_KP_MEMSTORE | 1<<30,
		SDLK_KP_MEMRECALL = SDL_SCANCODE_KP_MEMRECALL | 1<<30,
		SDLK_KP_MEMCLEAR = SDL_SCANCODE_KP_MEMCLEAR | 1<<30,
		SDLK_KP_MEMADD = SDL_SCANCODE_KP_MEMADD | 1<<30,
		SDLK_KP_MEMSUBTRACT = SDL_SCANCODE_KP_MEMSUBTRACT | 1<<30,
		SDLK_KP_MEMMULTIPLY = SDL_SCANCODE_KP_MEMMULTIPLY | 1<<30,
		SDLK_KP_MEMDIVIDE = SDL_SCANCODE_KP_MEMDIVIDE | 1<<30,
		SDLK_KP_PLUSMINUS = SDL_SCANCODE_KP_PLUSMINUS | 1<<30,
		SDLK_KP_CLEAR = SDL_SCANCODE_KP_CLEAR | 1<<30,
		SDLK_KP_CLEARENTRY = SDL_SCANCODE_KP_CLEARENTRY | 1<<30,
		SDLK_KP_BINARY = SDL_SCANCODE_KP_BINARY | 1<<30,
		SDLK_KP_OCTAL = SDL_SCANCODE_KP_OCTAL | 1<<30,
		SDLK_KP_DECIMAL = SDL_SCANCODE_KP_DECIMAL | 1<<30,
		SDLK_KP_HEXADECIMAL = SDL_SCANCODE_KP_HEXADECIMAL | 1<<30,
		SDLK_LCTRL = SDL_SCANCODE_LCTRL | 1<<30,
		SDLK_LSHIFT = SDL_SCANCODE_LSHIFT | 1<<30,
		SDLK_LALT = SDL_SCANCODE_LALT | 1<<30,
		SDLK_LGUI = SDL_SCANCODE_LGUI | 1<<30,
		SDLK_RCTRL = SDL_SCANCODE_RCTRL | 1<<30,
		SDLK_RSHIFT = SDL_SCANCODE_RSHIFT | 1<<30,
		SDLK_RALT = SDL_SCANCODE_RALT | 1<<30,
		SDLK_RGUI = SDL_SCANCODE_RGUI | 1<<30,
		SDLK_MODE = SDL_SCANCODE_MODE | 1<<30,
		SDLK_AUDIONEXT = SDL_SCANCODE_AUDIONEXT | 1<<30,
		SDLK_AUDIOPREV = SDL_SCANCODE_AUDIOPREV | 1<<30,
		SDLK_AUDIOSTOP = SDL_SCANCODE_AUDIOSTOP | 1<<30,
		SDLK_AUDIOPLAY = SDL_SCANCODE_AUDIOPLAY | 1<<30,
		SDLK_AUDIOMUTE = SDL_SCANCODE_AUDIOMUTE | 1<<30,
		SDLK_MEDIASELECT = SDL_SCANCODE_MEDIASELECT | 1<<30,
		SDLK_WWW = SDL_SCANCODE_WWW | 1<<30,
		SDLK_MAIL = SDL_SCANCODE_MAIL | 1<<30,
		SDLK_CALCULATOR = SDL_SCANCODE_CALCULATOR | 1<<30,
		SDLK_COMPUTER = SDL_SCANCODE_COMPUTER | 1<<30,
		SDLK_AC_SEARCH = SDL_SCANCODE_AC_SEARCH | 1<<30,
		SDLK_AC_HOME = SDL_SCANCODE_AC_HOME | 1<<30,
		SDLK_AC_BACK = SDL_SCANCODE_AC_BACK | 1<<30,
		SDLK_AC_FORWARD = SDL_SCANCODE_AC_FORWARD | 1<<30,
		SDLK_AC_STOP = SDL_SCANCODE_AC_STOP | 1<<30,
		SDLK_AC_REFRESH = SDL_SCANCODE_AC_REFRESH | 1<<30,
		SDLK_AC_BOOKMARKS = SDL_SCANCODE_AC_BOOKMARKS | 1<<30,
		SDLK_BRIGHTNESSDOWN = SDL_SCANCODE_BRIGHTNESSDOWN | 1<<30,
		SDLK_BRIGHTNESSUP = SDL_SCANCODE_BRIGHTNESSUP | 1<<30,
		SDLK_DISPLAYSWITCH = SDL_SCANCODE_DISPLAYSWITCH | 1<<30,
		SDLK_KBDILLUMTOGGLE = SDL_SCANCODE_KBDILLUMTOGGLE | 1<<30,
		SDLK_KBDILLUMDOWN = SDL_SCANCODE_KBDILLUMDOWN | 1<<30,
		SDLK_KBDILLUMUP = SDL_SCANCODE_KBDILLUMUP | 1<<30,
		SDLK_EJECT = SDL_SCANCODE_EJECT | 1<<30,
		SDLK_SLEEP = SDL_SCANCODE_SLEEP | 1<<30
	};

	typedef enum {
		KMOD_NONE = 0x0000,
		KMOD_LSHIFT = 0x0001,
		KMOD_RSHIFT = 0x0002,
		KMOD_LCTRL = 0x0040,
		KMOD_RCTRL = 0x0080,
		KMOD_LALT = 0x0100,
		KMOD_RALT = 0x0200,
		KMOD_LGUI = 0x0400,
		KMOD_RGUI = 0x0800,
		KMOD_NUM = 0x1000,
		KMOD_CAPS = 0x2000,
		KMOD_MODE = 0x4000,
		KMOD_RESERVED = 0x8000
	} SDL_Keymod;

	// mouse
	enum {
		SDL_BUTTON_LEFT = 1,
		SDL_BUTTON_MIDDLE = 2,
		SDL_BUTTON_RIGHT = 3,
		SDL_BUTTON_X1 = 4,
		SDL_BUTTON_X2 = 5
	};

	// events
	typedef enum {
		SDL_QUIT = 0x100,
		SDL_APP_TERMINATING,
		SDL_APP_LOWMEMORY,
		SDL_APP_WILLENTERBACKGROUND,
		SDL_APP_DIDENTERBACKGROUND,
		SDL_APP_WILLENTERFOREGROUND,
		SDL_APP_DIDENTERFOREGROUND,
		SDL_WINDOWEVENT = 0x200,
		SDL_SYSWMEVENT,
		SDL_KEYDOWN = 0x300,
		SDL_KEYUP,
		SDL_TEXTEDITING,
		SDL_TEXTINPUT,
		SDL_KEYMAPCHANGED,
		SDL_MOUSEMOTION = 0x400,
		SDL_MOUSEBUTTONDOWN,
		SDL_MOUSEBUTTONUP,
		SDL_MOUSEWHEEL,
		SDL_JOYAXISMOTION = 0x600,
		SDL_JOYBALLMOTION,
		SDL_JOYHATMOTION,
		SDL_JOYBUTTONDOWN,
		SDL_JOYBUTTONUP,
		SDL_JOYDEVICEADDED,
		SDL_JOYDEVICEREMOVED,
		SDL_CONTROLLERAXISMOTION = 0x650,
		SDL_CONTROLLERBUTTONDOWN,
		SDL_CONTROLLERBUTTONUP,
		SDL_CONTROLLERDEVICEADDED,
		SDL_CONTROLLERDEVICEREMOVED,
		SDL_CONTROLLERDEVICEREMAPPED,
		SDL_FINGERDOWN = 0x700,
		SDL_FINGERUP,
		SDL_FINGERMOTION,
		SDL_DOLLARGESTURE = 0x800,
		SDL_DOLLARRECORD,
		SDL_MULTIGESTURE,
		SDL_CLIPBOARDUPDATE = 0x900,
		SDL_DROPFILE = 0x1000,
		SDL_AUDIODEVICEADDED = 0x1100,
		SDL_AUDIODEVICEREMOVED,
		SDL_RENDER_TARGETS_RESET = 0x2000,
		SDL_RENDER_DEVICE_RESET,
		SDL_USEREVENT = 0x8000,
		SDL_LASTEVENT = 0xFFFF
	} SDL_EventType;

	enum {
		SDL_TEXTEDITINGEVENT_TEXT_SIZE = 32,
		SDL_TEXTINPUTEVENT_TEXT_SIZE = 32
	};

	typedef enum {
		SDL_SYSWM_UNKNOWN,
		SDL_SYSWM_WINDOWS,
		SDL_SYSWM_X11,
		SDL_SYSWM_DIRECTFB,
		SDL_SYSWM_COCOA,
		SDL_SYSWM_UIKIT,
		SDL_SYSWM_WAYLAND,
		SDL_SYSWM_MIR,
		SDL_SYSWM_WINRT,
		SDL_SYSWM_ANDROID
	} SDL_SYSWM_TYPE;

]]

if ffi.os == 'Windows' then
	ffi.cdef [[
		typedef struct SDL_SysWMmsg {
		    SDL_version version;
		    SDL_SYSWM_TYPE subsystem;
			struct {
				void* hwnd;
				uint32_t msg;
				uintptr_t wParam;
				intptr_t lParam;
			} win;
		} SDL_SysWMmsg;
	]]
else
	ffi.cdef [[
		typedef struct SDL_SysWMmsg {
		    SDL_version version;
		    SDL_SYSWM_TYPE subsystem;
		    int dummy;
		} SDL_SysWMmsg;
	]]
end

ffi.cdef [[

	typedef union SDL_Event {
		uint32_t type;
		struct { uint32_t type, timestamp; } common;
		struct { uint32_t type, timestamp, windowID; } common_window;
		struct {
			uint32_t type, timestamp, windowID;
			uint8_t event, padding1, padding2, padding3;
			int32_t data1, data2;
		} window;
		struct {
			uint32_t type, timestamp, windowID;
			uint8_t state, repeat, padding2, padding3;
			struct {
				SDL_Scancode scancode;
				int32_t sym;
				uint16_t mod;
				uint32_t unused;
			} keysym;
		} key;
		struct {
			uint32_t type, timestamp, windowID;
			char text[SDL_TEXTEDITINGEVENT_TEXT_SIZE];
			int32_t start, length;
		} edit;
		struct {
			uint32_t type, timestamp, windowID;
			char text[SDL_TEXTINPUTEVENT_TEXT_SIZE];
		} text;
		struct {
			uint32_t type, timestamp, windowID, which, state;
			int32_t x, y, xrel, yrel;
		} motion;
		struct {
			uint32_t type, timestamp, windowID, which;
			uint8_t button, state, clicks, padding1;
			int32_t x, y;
		} button;
		struct {
			uint32_t type, timestamp, windowID, which;
			int32_t x, y;
			uint32_t direction;
		} wheel;
		struct {
			uint32_t type, timestamp;
			int32_t which;
			uint32_t axis, padding1, padding2, padding3;
			int16_t value;
			uint16_t padding4;
		} jaxis;
		struct {
			uint32_t type, timestamp;
			int32_t which;
			uint8_t ball, padding1, padding2, padding3;
			int16_t xrel, yrel;
		} jball;
		struct {
			uint32_t type, timestamp;
			int32_t which;
			uint8_t hat, value, padding1, padding2;
		} jhat;
		struct {
			uint32_t type, timestamp;
			int32_t which;
			uint8_t button, state, padding1, padding2;
		} jbutton;
		struct {
			uint32_t type, timestamp;
			int32_t which;
		} jdevice;
		struct {
			uint32_t type, timestamp;
			int32_t which;
			uint8_t axis, padding1, padding2, padding3;
			int16_t value;
			uint16_t padding4;
		} caxis;
		struct {
			uint32_t type, timestamp;
			int32_t which;
			uint8_t button, state, padding1, padding2;
		} cbutton;
		struct {
			uint32_t type, timestamp;
			int32_t which;
		} cdevice;
		struct {
			uint32_t type, timestamp, which;
			uint8_t iscapture, padding1, padding2, padding3;
		} adevice;
		struct {
			uint32_t type, timestamp;
		} quit;
		struct {
			uint32_t type, timestamp, windowID;
			int32_t code;
			void* data1;
			void* data2;
		} user;
		struct {
			uint32_t type, timestamp;
			SDL_SysWMmsg* msg;
		} syswm;
		struct {
			uint32_t type, timestamp;
			int64_t touchId, fingerId;
			float x, y, dx, dy, pressure;
		} tfinger;
		struct {
			uint32_t type, timestamp;
			int64_t touchId;
			float dTheta, dDist, x, y;
			uint16_t numFingers, padding;
		} mgesture;
		struct {
			uint32_t type, timestamp;
			int64_t touchId, gestureId;
			uint32_t numFingers;
			float error, x, y;
		} dgesture;
		struct {
			uint32_t type, timestamp;
			char* file;
		} drop;
		uint8_t padding[56];
	} SDL_Event;

	int SDL_PollEvent(SDL_Event*);
	int SDL_WaitEvent(SDL_Event*);
	int SDL_WaitEventTimeout(SDL_Event* event, int timeout);
	int SDL_PushEvent(SDL_Event*);
	uint32_t SDL_RegisterEvents(int num);

	// rect
	typedef struct SDL_Rect { int x,y,w,h; } SDL_Rect;

	// pixel formats
	typedef struct SDL_Color { uint8_t r,g,b,a; } SDL_Color;

	typedef struct SDL_Palette {
		int ncolors;
		SDL_Color* colors;
		uint32_t version;
		int refcount;
	} SDL_Palette;

	typedef struct SDL_PixelFormat {
		uint32_t format;
		SDL_Palette* palette;
		uint8_t BitsPerPixel, BytesPerPixel, padding[2];
		uint32_t Rmask, Gmask, Bmask, Amask;
		uint8_t Rloss, Gloss, Bloss, Aloss;
		uint8_t Rshift, Gshift, Bshift, Ashift;
		int refcount;
		struct SDL_PixelFormat* next;
	} SDL_PixelFormat;

	// surface
	enum {
		SDL_PREALLOC = 0x00000001,
		SDL_RLEACCEL = 0x00000002,
		SDL_DONTFREE = 0x00000004
	};
	typedef struct SDL_Surface {
		uint32_t flags;
		SDL_PixelFormat* format;    /**< Read-only */
		int w, h;                   /**< Read-only */
		int pitch;                  /**< Read-only */
		uint8_t* pixels;               /**< Read-write */
		void *userdata;             /**< Read-write */
		int locked;                 /**< Read-only */
		void* lock_data;            /**< Read-only */
		SDL_Rect clip_rect;         /**< Read-only */
		struct SDL_BlitMap* map;    /**< Private */
		int refcount;               /**< Read-mostly */
	} SDL_Surface;
	int SDL_LockSurface(SDL_Surface*);
	void SDL_UnlockSurface(SDL_Surface*);
	int SDL_UpperBlit(SDL_Surface* src, const SDL_Rect* src_rect, SDL_Surface* dst, SDL_Rect* dst_rect);
	typedef enum {
		SDL_BLENDMODE_NONE = 0x00000000,
		SDL_BLENDMODE_BLEND = 0x00000001,
		SDL_BLENDMODE_ADD = 0x00000002,
		SDL_BLENDMODE_MOD = 0x00000004
	} SDL_BlendMode;
	int SDL_SetSurfaceBlendMode(SDL_Surface*, SDL_BlendMode);
	int SDL_FillRect(SDL_Surface*, const SDL_Rect*, uint32_t color);

	// accelerated 2D
	typedef struct SDL_Texture SDL_Texture;
	typedef struct SDL_Renderer SDL_Renderer;
	enum {
	    SDL_RENDERER_SOFTWARE = 0x00000001,
	    SDL_RENDERER_ACCELERATED = 0x00000002,
	    SDL_RENDERER_PRESENTVSYNC = 0x00000004,
	    SDL_RENDERER_TARGETTEXTURE = 0x00000008
	};
	SDL_Renderer* SDL_CreateRenderer(SDL_Window*, int index, uint32_t flags);
	int SDL_RenderClear(SDL_Renderer*);
	void SDL_RenderPresent(SDL_Renderer*);
	int SDL_RenderCopy(SDL_Renderer*, SDL_Texture*, const SDL_Rect* src, const SDL_Rect* dst);
	SDL_Texture* SDL_CreateTextureFromSurface(SDL_Renderer*, SDL_Surface*);
	SDL_Surface* SDL_CreateRGBSurface(
		uint32_t flags, int width, int height, int depth,
		uint32_t rmask, uint32_t gmask, uint32_t bmask, uint32_t amask);

	// read/write operations
	enum {
		SDL_RWOPS_UNKNOWN,
		SDL_RWOPS_WINFILE,
		SDL_RWOPS_STDFILE,
		SDL_RWOPS_JNIFILE,
		SDL_RWOPS_MEMORY,
		SDL_RWOPS_MEMORY_RO
	};

	typedef struct SDL_RWops {
		int64_t (*size) (struct SDL_RWops*);
		int64_t (*seek) (struct SDL_RWops*, int64_t offset, int whence);
		size_t (*read) (struct SDL_RWops*, void *ptr, size_t size, size_t maxnum);
		size_t (*write) (struct SDL_RWops*, const void *ptr, size_t size, size_t num);
		int (*close) (struct SDL_RWops*);

		uint32_t type;
		union {
		/*
#if defined(__ANDROID__)
			struct {
				void *fileNameRef;
				void *inputStreamRef;
				void *readableByteChannelRef;
				void *readMethod;
				void *assetFileDescriptorRef;
				long position;
				long size;
				long offset;
				int fd;
			} androidio;
#elif defined(__WIN32__)
			struct {
				SDL_bool append;
				void *h;
				struct {
					void *data;
					size_t size;
					size_t left;
				} buffer;
			} windowsio;
#endif
#ifdef HAVE_STDIO_H
			struct {
				SDL_bool autoclose;
				FILE* fp;
			} stdio;
#endif
		*/
			struct {
				uint8_t* base;
				uint8_t* here;
				uint8_t* stop;
			} mem;
			struct {
				void* data1;
				void* data2;
			} unknown;
		} hidden;
	} SDL_RWops;

	SDL_RWops* SDL_RWFromMem(void*, int);

	// cursors
	typedef struct SDL_Cursor SDL_Cursor;
	typedef enum {
		SDL_SYSTEM_CURSOR_ARROW,
		SDL_SYSTEM_CURSOR_IBEAM,
		SDL_SYSTEM_CURSOR_WAIT,
		SDL_SYSTEM_CURSOR_CROSSHAIR,
		SDL_SYSTEM_CURSOR_WAITARROW,
		SDL_SYSTEM_CURSOR_SIZENWSE,
		SDL_SYSTEM_CURSOR_SIZENESW,
		SDL_SYSTEM_CURSOR_SIZEWE,
		SDL_SYSTEM_CURSOR_SIZENS,
		SDL_SYSTEM_CURSOR_SIZEALL,
		SDL_SYSTEM_CURSOR_NO,
		SDL_SYSTEM_CURSOR_HAND,
		SDL_NUM_SYSTEM_CURSORS
	} SDL_SystemCursor;
	SDL_Cursor* SDL_CreateSystemCursor(SDL_SystemCursor);
	void SDL_SetCursor(SDL_Cursor*);

]]

return lib