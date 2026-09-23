import subprocess
import sys

exe_path = r"C:\Users\0SLEK\Documents\antiganloker\release\AG_2.5.0.exe"

try:
    p = subprocess.Popen(
        [exe_path],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        encoding='utf-8',
        errors='replace'
    )
    out, err = p.communicate(input="1\n\n\n\n0\n", timeout=120)
    print("=== STDOUT ===")
    print(out)
    if err:
        print("=== STDERR ===")
        print(err)
except subprocess.TimeoutExpired:
    print("Process timed out")
    p.kill()
    out, err = p.communicate()
    print("=== STDOUT (partial) ===")
    print(out)
    if err:
        print("=== STDERR (partial) ===")
        print(err)
except Exception as e:
    print(f"Error: {e}")
