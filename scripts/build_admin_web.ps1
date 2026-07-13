# Build admin web app for Firebase hosting (build/web_admin).
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Push-Location $PSScriptRoot\..

flutter build web `
  -t lib/main_admin.dart `
  --no-tree-shake-icons `
  --no-wasm-dry-run `
  -o build/web_admin

Pop-Location

Write-Host "Admin web build complete: build/web_admin"
