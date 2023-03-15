@echo off

echo Removing bloatware from Windows...

setlocal EnableDelayedExpansion

rem Create an array of the applications to remove
set "applications[0]=3D Viewer"
set "applications[1]=Alarms & Clock"
set "applications[2]=Feedback Hub"
set "applications[3]=Get Help"
set "applications[4]=Groove Music"
set "applications[5]=Microsoft Solitaire Collection"
set "applications[6]=News & Interests"
set "applications[7]=Paint 3D"
set "applications[8]=Skype"
set "applications[9]=Snip & Sketch"
set "applications[10]=Sticky Notes"
set "applications[11]=Tips"
set "applications[12]=Your Phone"

rem Show a list of the applications and prompt the user to select which ones to remove
set /a index=0
set "removeApplications="
set "keepApplications="
:prompt
cls
echo Please select the applications to remove:
for /L %%i in (0,1,12) do (
  set /a number=%%i+1
  set "application=!applications[%%i]!"
  echo !number!. !application!
)
set /p "selection=Enter the numbers (separated by spaces) of the applications to remove, or press Enter to keep all: "
if "%selection%"=="" goto keepAll
for %%i in (%selection%) do (
  set /a index=%%i-1
  if not defined applications[!index!] (
    echo Invalid selection: !selection!
    pause
    goto prompt
  )
  set "removeApplications=!removeApplications!,!applications[!index!]!"
)
set "removeApplications=%removeApplications:~1%"
goto confirm

:keepAll
set "keepApplications=!applications[0]!"
for /L %%i in (1,1,12) do (
  set "keepApplications=!keepApplications!,!applications[%%i]!"
)
goto confirm

:confirm
echo.
if defined removeApplications (
  echo The following applications will be removed:
  echo %removeApplications%
  echo.
  set /p "confirm=Do you want to continue? (Y/N): "
  if /i not "%confirm%"=="Y" goto end
) else (
  echo No applications will be removed.
  pause
  goto end
)

rem Remove the selected applications
for /L %%i in (0,1,12) do (
  set "application=!applications[%%i]!"
  if "!removeApplications:,%application%,=!"=="%removeApplications%" (
    set "keepApplications=!keepApplications!,!application!"
  ) else (
    echo Removing !application!...
    powershell -Command "Get-AppxPackage *!application:* = *! | Remove-AppxPackage"
  )
)

echo Bloatware removal complete.
pause

:end
