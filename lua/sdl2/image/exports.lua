
local ffi = require 'ffi'

local lib = ffi.load 'SDL2_image'

require 'sdl2.exports'

ffi.cdef [[

	enum {
		SDL_IMAGE_MAJOR_VERSION = 2,
		SDL_IMAGE_MINOR_VERSION = 0,
		SDL_IMAGE_PATCHLEVEL = 1,

	    IMG_INIT_JPG = 0x00000001,
	    IMG_INIT_PNG = 0x00000002,
	    IMG_INIT_TIF = 0x00000004,
	    IMG_INIT_WEBP = 0x00000008
	};

	const SDL_version* IMG_Linked_Version();
	int IMG_Init(int flags);
	void IMG_Quit();
	SDL_Surface* IMG_LoadTyped_RW(SDL_RWops*, int freesrc, const char* type);
	SDL_Surface* IMG_Load(const char *file);
	SDL_Surface* IMG_Load_RW(SDL_RWops*, int freesrc);

	SDL_Texture* IMG_LoadTexture(SDL_Renderer*, const char* file);
	SDL_Texture* IMG_LoadTexture_RW(SDL_Renderer*, SDL_RWops*, int freesrc);
	SDL_Texture* IMG_LoadTextureTyped_RW(SDL_Renderer*, SDL_RWops*, int freesrc, const char* type);

	int IMG_isICO(SDL_RWops*);
	int IMG_isCUR(SDL_RWops*);
	int IMG_isBMP(SDL_RWops*);
	int IMG_isGIF(SDL_RWops*);
	int IMG_isJPG(SDL_RWops*);
	int IMG_isLBM(SDL_RWops*);
	int IMG_isPCX(SDL_RWops*);
	int IMG_isPNG(SDL_RWops*);
	int IMG_isPNM(SDL_RWops*);
	int IMG_isTIF(SDL_RWops*);
	int IMG_isXCF(SDL_RWops*);
	int IMG_isXPM(SDL_RWops*);
	int IMG_isXV(SDL_RWops*);
	int IMG_isWEBP(SDL_RWops*);

	SDL_Surface* IMG_LoadICO_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadCUR_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadBMP_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadGIF_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadJPG_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadLBM_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadPCX_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadPNG_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadPNM_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadTGA_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadTIF_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadXCF_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadXPM_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadXV_RW(SDL_RWops*);
	SDL_Surface* IMG_LoadWEBP_RW(SDL_RWops*);

	SDL_Surface* IMG_ReadXPMFromArray(char** xpm);
	int IMG_SavePNG(SDL_Surface*, const char* file);
	int IMG_SavePNG_RW(SDL_Surface*, SDL_RWops*, int freedst);

]]

return lib
