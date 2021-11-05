"C:\Program Files\7-Zip\7z.exe" a -tzip "CotdCountdown.op" "*"
del "C:\Users\matth\OpenplanetNext\Plugins\CotdCountdown.op"
move "CotdCountdown.op" "C:\Users\matth\OpenplanetNext\Plugins\CotdCountdown.op"

:: Get-Content -Path "C:\Users\matth\OpenplanetNext\Openplanet.log" -Wait