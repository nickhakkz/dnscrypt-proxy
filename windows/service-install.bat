@SFC 2>&1 | FIND /i "/SCANNOW" >NUL
@IF %ERRORLEVEL% NEQ 0 GOTO ELEVATE
@GOTO ADMINTASKS

:ELEVATE
ECHO Elevated privileges are temporarily required, just to register or remove the dnscrypt-proxy service
CD /d %~dp0
MSHTA "javascript: var shell = new ActiveXObject('shell.application'); shell.ShellExecute('%~nx0', '', '', 'runas', 1); close();"
EXIT

:ADMINTASKS

@CD /d %~dp0

.\dnscrypt-proxy.exe -service install
.\dnscrypt-proxy.exe -service start

@ECHO ""
@SET /P _=Thank you for using dnscrypt-proxy! Hit [RETURN] to finish

EXIT
