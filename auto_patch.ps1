$exePath = "C:\Users\0SLEK\Documents\antiganloker\release\AG_2.5.0.exe"

if (-not (Test-Path $exePath)) {
    Write-Host "[ERROR] Файл не найден: $exePath"
    exit 1
}

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $exePath
$psi.RedirectStandardInput = $true
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.UseShellExecute = $false
$psi.CreateNoWindow = $false

$process = [System.Diagnostics.Process]::Start($psi)

Start-Sleep -Milliseconds 500

$process.StandardInput.WriteLine("1")
$process.StandardInput.Flush()

Start-Sleep -Seconds 3

$process.StandardInput.WriteLine("")
$process.StandardInput.Flush()

$process.WaitForExit(60000)

$output = $process.StandardOutput.ReadToEnd()
Write-Host $output
