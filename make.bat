echo off
set path=%path%;c:\masm32\bin
ml  /c  /coff  /Cp stars.asm || goto :error
ml  /c  /coff  /Cp lines.asm || goto :error
ml  /c  /coff  /Cp blit.asm || goto :error
ml  /c  /coff  /Cp game.asm || goto :error

link /SUBSYSTEM:WINDOWS  /LIBPATH:c:\masm32\lib  game.obj blit.obj lines.obj stars.obj libgame.obj || goto :error

pause
	echo Executable built succesfully.
goto :EOF

:error
echo Failed with error #%errorlevel%
pause



