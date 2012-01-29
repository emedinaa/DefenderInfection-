@echo off

:: AIR application packaging
:: More information:
:: http://livedocs.adobe.com/flex/3/html/help.html?content=CommandLineTools_5.html#1035959

:: Path to Flex SDK binaries
::set PATH=%PATH%;$(FlexSDK)\bin
set PATH=%PATH%;"D:\DEV\SDK\FLEX\4.5.1.8\flex_sdk_4.5.0.18623\bin"

:: Signature (see 'CreateCertificate.bat')
set CERTIFICATE="DefenderInfection.pfx"
set SIGNING_OPTIONS=-storetype pkcs12 -keystore %CERTIFICATE% -tsa none 
if not exist %CERTIFICATE% goto certificate

:: Output
if not exist air md air
set AIR_FILE=air/InfectionDefender.air

:: Input
set APP_XML=application.xml 
set FILE_OR_DIR=-C bin .

echo Signing AIR setup using certificate %CERTIFICATE%.
call adt -package %SIGNING_OPTIONS% %AIR_FILE% %APP_XML% %FILE_OR_DIR%
if errorlevel 1 goto failed

echo.
echo AIR setup created: %AIR_FILE%
echo.
goto end

:certificate
echo Certificate not found: %CERTIFICATE%
echo.
echo Troubleshotting: 
echo A certificate is required, generate one using 'CreateCertificate.bat'
echo.
goto end

:failed
echo AIR setup creation FAILED.
echo.
echo Troubleshotting: 
echo did you configure the Flex SDK path in this Batch file?
echo.

:end
pause
