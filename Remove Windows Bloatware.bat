@echo off
setlocal EnableExtensions EnableDelayedExpansion

echo Windows Debloater (Batch)
echo.

rem Keep package identities explicit. Display names are used only for the menu.
set "app_name[0]=3D Viewer"
set "app_id[0]=Microsoft.Microsoft3DViewer"
set "app_name[1]=Alarms and Clock"
set "app_id[1]=Microsoft.WindowsAlarms"
set "app_name[2]=Feedback Hub"
set "app_id[2]=Microsoft.WindowsFeedbackHub"
set "app_name[3]=Get Help"
set "app_id[3]=Microsoft.GetHelp"
set "app_name[4]=Groove Music"
set "app_id[4]=Microsoft.ZuneMusic"
set "app_name[5]=Microsoft Solitaire Collection"
set "app_id[5]=Microsoft.MicrosoftSolitaireCollection"
set "app_name[6]=Paint 3D"
set "app_id[6]=Microsoft.MSPaint"
set "app_name[7]=Skype"
set "app_id[7]=Microsoft.SkypeApp"
set "app_name[8]=Snipping Tool"
set "app_id[8]=Microsoft.ScreenSketch"
set "app_name[9]=Sticky Notes"
set "app_id[9]=Microsoft.MicrosoftStickyNotes"
set "app_name[10]=Tips"
set "app_id[10]=Microsoft.Getstarted"
set "app_name[11]=Phone Link"
set "app_id[11]=Microsoft.YourPhone"
set /a app_count=12

:prompt
cls
echo Select applications to remove:
echo Enter numbers separated by spaces, or press Enter to cancel.
echo.
for /L %%i in (0,1,11) do (
  set /a number=%%i+1
  echo !number!. !app_name[%%i]!
)
set "selection="
set /p "selection=Selection: "
if not defined selection goto end

set "selected_indexes="
for %%i in (%selection%) do (
  set /a index=%%i-1
  if !index! LSS 0 goto invalid
  if !index! GEQ %app_count% goto invalid
  set "selected_indexes=!selected_indexes! !index!"
)

echo.
echo The following applications will be removed for the current user:
for %%i in (!selected_indexes!) do echo - !app_name[%%i]!
echo.
choice /C YN /N /M "Continue"
if errorlevel 2 goto end

for %%i in (!selected_indexes!) do (
  echo Removing !app_name[%%i]!...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$pkg=Get-AppxPackage -Name '!app_id[%%i]!'; if($pkg){$pkg ^| Remove-AppxPackage -ErrorAction Stop; exit 0}else{Write-Host 'Not installed for the current user.'; exit 0}"
  if errorlevel 1 (
    echo Failed to remove !app_name[%%i]!.
  ) else (
    echo Done.
  )
)

echo.
echo Removal run complete. Review any failures above.
pause

:end
endlocal
exit /b 0

:invalid
echo.
echo Invalid selection. Enter only numbers from 1 to %app_count%.
pause
goto prompt
