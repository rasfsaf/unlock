$exe = 'C:\Users\0SLEK\Documents\antiganloker\release\AG_2.5.0.exe'
$log = 'C:\Users\0SLEK\Documents\antiganloker\unlock_log.txt'
"Starting unlock at $(Get-Date)..." | Out-File $log -Encoding UTF8

try {
    $psi = New-Object System.Diagnostics.ProcessStartInfo
    $psi.FileName = $exe
    $psi.RedirectStandardInput = $true
    $psi.RedirectStandardOutput = $true
    $psi.RedirectStandardError = $true
    $psi.UseShellExecute = $false
    $psi.CreateNoWindow = $true
    $psi.StandardOutputEncoding = [System.Text.Encoding]::UTF8
    $psi.StandardErrorEncoding = [System.Text.Encoding]::UTF8

    $p = [System.Diagnostics.Process]::Start($psi)
    if (-not $p) { throw "Failed to start process" }

    Start-Sleep -Milliseconds 2000
    $p.StandardInput.WriteLine("1")
    $p.StandardInput.Flush()
    
    # Wait for patching operations
    Start-Sleep -Seconds 90
    
    # Send Enter to dismiss any completion prompts
    $p.StandardInput.WriteLine("")
    $p.StandardInput.Flush()
    Start-Sleep -Seconds 5
    
    # Exit main menu
    $p.StandardInput.WriteLine("0")
    $p.StandardInput.Flush()
    Start-Sleep -Seconds 3
    
    if (-not $p.HasExited) { $p.Kill() }
    $p.WaitForExit()

    $out = $p.StandardOutput.ReadToEnd()
    $err = $p.StandardError.ReadToEnd()
    
    "=== STDOUT ===" | Out-File $log -Append -Encoding UTF8
    $out | Out-File $log -Append -Encoding UTF8
    if ($err) {
        "=== STDERR ===" | Out-File $log -Append -Encoding UTF8
        $err | Out-File $log -Append -Encoding UTF8
    }
    "Completed with exit code $($p.ExitCode)" | Out-File $log -Append -Encoding UTF8
} catch {
    "ERROR: $_" | Out-File $log -Append -Encoding UTF8
}
