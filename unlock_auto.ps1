$exePath = 'C:\Users\0SLEK\Documents\antiganloker\release\AG_2.5.0.exe'
if (-not (Test-Path $exePath)) { Write-Host "[ERROR] Файл не найден: $exePath"; exit 1 }

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $exePath
$psi.RedirectStandardInput = $true
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.UseShellExecute = $false
$psi.CreateNoWindow = $true
$psi.StandardOutputEncoding = [System.Text.Encoding]::UTF8
$psi.StandardErrorEncoding = [System.Text.Encoding]::UTF8

$process = [System.Diagnostics.Process]::Start($psi)

# Асинхронное чтение stdout/stderr чтобы избежать дедлока
$stdoutTask = $process.StandardOutput.ReadToEndAsync()
$stderrTask = $process.StandardError.ReadToEndAsync()

Start-Sleep -Milliseconds 1500

# Выбор пункта 1
$process.StandardInput.WriteLine("1")
$process.StandardInput.Flush()

# Ждем выполнения патчинга
Start-Sleep -Seconds 60

# Подтверждение / выход из подменю
$process.StandardInput.WriteLine("")
$process.StandardInput.Flush()
Start-Sleep -Seconds 3

# Выход из главного меню
$process.StandardInput.WriteLine("0")
$process.StandardInput.Flush()
Start-Sleep -Seconds 2

if (-not $process.HasExited) {
    $process.Kill()
}

$process.WaitForExit()

$output = $stdoutTask.Result
$err = $stderrTask.Result

Write-Host "=== STDOUT ==="
Write-Host $output
if ($err) {
    Write-Host "=== STDERR ==="
    Write-Host $err
}
