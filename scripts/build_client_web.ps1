# Build client web app for Firebase hosting (build/web_client).
# --no-tree-shake-icons avoids icon subsetting failures with custom icon fonts.
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Push-Location $PSScriptRoot\..

flutter build web `
  -t lib/main_client.dart `
  --no-tree-shake-icons `
  --no-wasm-dry-run `
  -o build/web_client

Pop-Location

Write-Host "Client web build complete: build/web_client"
