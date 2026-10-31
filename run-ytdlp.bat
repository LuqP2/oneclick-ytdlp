
@echo off
setlocal DisableDelayedExpansion

:: Sem argumentos, registra a localização do BAT
if "%~1"=="" goto registrar

:: Recebe e recupera a URL enviada pelo Chrome
set "url=%~1"
set "url=%url:ytdlp://=%"
set "url=%url:https//=https://%"
set "url=%url:http//=http://%"

:: Usa a pasta do próprio BAT como destino
cd /d "%~dp0"

echo Baixando em: %CD%
echo URL: %url%
echo.

:: Baixa e abre o Explorer com o arquivo selecionado
yt-dlp --exec "after_move:explorer.exe /select," "%url%"

if errorlevel 1 pause
exit /b

:registrar
:: Registra o protocolo ytdlp:// no Windows
reg add "HKCU\Software\Classes\ytdlp" /ve /t REG_SZ /d "URL:yt-dlp Protocol" /f >nul
if errorlevel 1 goto erro

reg add "HKCU\Software\Classes\ytdlp" /v "URL Protocol" /t REG_SZ /d "" /f >nul
if errorlevel 1 goto erro

reg add "HKCU\Software\Classes\ytdlp\shell\open\command" /ve /t REG_SZ /d "\"%~f0\" \"%%1\"" /f >nul
if errorlevel 1 goto erro

echo Protocolo registrado com sucesso!
echo.
echo Destino dos downloads:
echo %~dp0
echo.
pause
exit /b

:erro
echo Erro ao registrar o protocolo.
pause
exit /b 1
