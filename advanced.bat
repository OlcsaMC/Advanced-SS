@echo off
:: Állítsd be a karakterkódolást UTF-8-ra a parancssorban
chcp 65001

:START
:: Írd ki a szkript szöveget
echo Minecraft Anti-Cheat Ellenőrzés
echo Válassz egy opciót a számok megadásával:
echo 1. CPU ellenőrzés
echo 2. Memória ellenőrzés
echo 3. Process lista megtekintése
echo 4. Gépi adatok megtekintése
echo 5. Rendszerindítási idő ellenőrzése
echo 6. Hálózati kapcsolatok ellenőrzése
echo 7. Kilépés

:: Kérd be a felhasználói választást
set /p valasztas="Add meg a választásod (1-7): "

:: Különböző opciók kezelése
if "%valasztas%"=="1" (
    echo CPU ellenőrzés folyamatban...
    powershell -Command "Get-WmiObject -Class Win32_Processor | Select-Object Name, LoadPercentage | Format-Table -AutoSize"
)
if "%valasztas%"=="2" (
    echo Memória ellenőrzés folyamatban...
    powershell -Command "Get-WmiObject -Class Win32_OperatingSystem | Select-Object TotalVisibleMemorySize, FreePhysicalMemory | Format-Table -AutoSize"
)
if "%valasztas%"=="3" (
    echo Process lista megtekintése...
    powershell -Command "Get-Process | Select-Object Name, Id | Format-Table -AutoSize"
)
if "%valasztas%"=="4" (
    echo Gépi adatok megtekintése...
    powershell -Command "[System.Net.Dns]::GetHostName()"
    powershell -Command "(Get-NetIPAddress | Select-Object -First 1 -Property IPAddress).IPAddress"
)
if "%valasztas%"=="5" (
    echo Rendszerindítási idő ellenőrzése...
    powershell -Command "((Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime | Out-String).Trim()"
)
if "%valasztas%"=="6" (
    echo Hálózati kapcsolatok ellenőrzése...
    netstat -an
)
if "%valasztas%"=="7" (
    echo Kilépés...
    exit /b
)
if "%valasztas%" NEQ "1" if "%valasztas%" NEQ "2" if "%valasztas%" NEQ "3" if "%valasztas%" NEQ "4" if "%valasztas%" NEQ "5" if "%valasztas%" NEQ "6" if "%valasztas%" NEQ "7" (
    echo Érvénytelen választás.
)

:: Kis szünet az eredmények megtekintésére
echo.
echo Nyomj meg egy billentyűt az újraindításhoz...
pause >nul

:: Menüpontok újraindítása
goto START
