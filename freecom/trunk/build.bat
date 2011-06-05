@echo off

set SWAP=YES-DXMS-SWAP____________________
if NOT "%SWAP%"=="YES-DXMS-SWAP____________________" goto err1
: BEGIN Internal stuff for ska -- If one of these three commands
:       fail for you, your distribution is broken! Please report.
for %%a in (lib\lib.mak cmd\cmd.mak shell\command.mak) do if not exist %%a set SWAP=NO
if "%SWAP%"=="NO" set XMS_SWAP=
if "%SWAP%"=="NO" call dmake dist
: END
set SWAP=

set COMPILER=TURBOCPP
if not exist config.bat goto err3
if not exist config.mak goto err2
call config.bat
if exist lastmake.mk call clean.bat
if "%1"=="-r" call clean.bat
if "%1"=="-r" shift
if "%1"=="clean" clean.bat
if "%1"=="clean" goto ende
if "%1"=="-h" goto help

:loop_commandline
if "%1"=="xms-swap" goto special
if "%1"=="debug"    goto special
if "%1"=="wc"       goto special
if "%1"=="tc"       goto special
if "%1"=="tcpp"     goto special
if "%1"=="bc"       goto special
goto run

:special
if "%1"=="xms-swap" set XMS_SWAP=1
if "%1"=="debug"    set DEBUG=1
if "%1"=="wc"       set COMPILER=WATCOM
if "%1"=="tc"       set COMPILER=TC2
if "%1"=="tcpp"     set COMPILER=TURBOCPP
if "%1"=="bc"       set COMPILER=BC5
shift
if not "%1" == "" goto loop_commandline

if not "%1"=="-h" goto run

:help
echo Build FreeCOM
echo Usage: %0 [-r] [clean] [xms-swap] [debug] [language]
echo -r: Rebuild -- Clean before proceed
echo clean: Remove *.OBJ, *.COM, *.LIB, etc. files, then exit
echo xms-swap: Build FreeCOM with XMS-Only Swap support
echo debug: Build FreeCOM with debug settings.
echo You can select for which language to built FreeCOM by setting
echo the environment variable LNG before running this script, e.g.:
echo SET LNG=german
echo selects the German language. For available language see STRINGS\*.LNG
goto ende

:run
if not x%1==x set LNG=%1
if "%lng%"=="" set LNG=english
echo Building FreeCOM for language %LNG%

if not "%MAKE%" == "" goto skip_make

if "%COMPILER%" == "TC2"      set MAKE=%TC2_BASE%\make -f
if "%COMPILER%" == "TURBOCPP" set MAKE=%TP1_BASE%\bin\make -f
if "%COMPILER%" == "BC5"      set MAKE=%BC5_BASE%\bin\make -f
if "%COMPILER%" == "WATCOM"   set MAKE=wmake /ms /h /f 

echo Make is %MAKE%.

:skip_make

echo.
echo Checking SUPPL library
cd suppl
if exist skip goto endSuppl
echo Building SUPPL library
%MAKE%suppl.mak all
if errorlevel 1 goto ende
cd src
%MAKE%suppl.mak all
if errorlevel 1 goto ende
cd ..
:endSuppl
cd ..

echo.
echo Making basic utilities for build process
echo.
cd utils
%MAKE%utils.mak all
if errorlevel 1 goto ende
cd ..

echo.
echo Making STRINGS resource
echo.
cd strings
%MAKE%strings.mak all
if errorlevel 1 goto ende
cd ..

echo.
echo Making CRITER resource
echo.
cd criter
%MAKE%criter.mak all
if errorlevel 1 goto ende
cd ..

echo.
echo Making misc library
echo.
cd lib
%MAKE%lib.mak all
if errorlevel 1 goto ende
cd ..

echo.
echo Making commands library
echo.
cd cmd
%MAKE%cmd.mak all
if errorlevel 1 goto ende
cd ..

echo.
echo Making COMMAND.COM
echo.
cd shell
%MAKE%command.mak all
if errorlevel 1 goto ende
cd ..

utils\mkinfres.exe /tinfo.txt infores shell\command.map shell\command.exe
copy /b shell\command.exe + infores + criter\criter1 + criter\criter + strings\strings.dat command.com
if not exist command.com goto ende

echo.
echo Making supplemental tools
echo.
cd tools
type tools.m1 >tools.mak
..\utils\mktools.exe >>tools.mak
type tools.m2 >>tools.mak
%MAKE%tools.mak all
if errorlevel 1 goto ende
cd ..

echo.
echo Patching heap size to 6KB
echo.
tools\ptchsize.exe command.com +6KB

echo.
echo All done. COMMAND.COM is ready for usage!
echo.
if NOT "%XMS_SWAP%"=="" goto ende

echo Note: To build the XMS-Only Swap featured FreeCOM, re-run
echo BUILD.BAT -r xms-swap %LNG%
goto ende

:err3
echo Please copy CONFIG.B into CONFIG.BAT and update the
echo settings therein.
goto ende

:err2
echo Please copy CONFIG.STD into CONFIG.MAK and update the
echo settings therein.
goto ende

:err1
echo Environment full (cannot add environment variables)
echo Cannot proceed

:ende
set XMS_SWAP=
set DEBUG=
set MAKE=
set COMPILER=
set TC2_BASE=
set TP1_BASE=
set BC5_BASE=
set XNASM=
set LNG=
