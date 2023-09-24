dir -R | foreach { $_.LastWriteTime = [System.DateTime]::Now }
pause