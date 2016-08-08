
@if not defined INCLUDE goto :FAIL

@setlocal

@echo off

@set STATIC_LIBS_LIST=

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@if exist lib\whereami.lib goto :BUILT_WHEREAMI
cl /nologo /c ^
	/I include ^
	/Fo.\lib\whereami\ ^
	lib\whereami\*.c
lib /nologo /nodefaultlib ^
	lib\whereami\*.obj -OUT:lib\whereami.lib
@if errorlevel 1 goto :BAD
@del lib\whereami\*.obj
:BUILT_WHEREAMI
@set STATIC_LIBS_LIST=%STATIC_LIBS_LIST%;whereami
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
cl /nologo /c /O2 /W3 /DWIN32 /D_CRT_SECURE_NO_DEPRECATE ^
	/I include ^
	/DSTATIC_LIBS_LIST=\"%STATIC_LIBS_LIST%\" ^
	*.c
@if errorlevel 1 goto :BAD
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
link /nologo ^
	/out:..\skeleton.exe ^
	lib\*.lib ^
	user32.lib ^
	*.obj
@if errorlevel 1 goto :BAD

@del *.obj

:BUILT_SKELETON
@echo Build successful!
@goto :END
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:BAD
@echo.
@echo *******************************************************
@echo *** Build FAILED -- Please check the error messages ***
@echo *******************************************************
@goto :END
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:FAIL
@echo You must open a "Visual Studio .NET Command Prompt" to run this script
@pause
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:END
