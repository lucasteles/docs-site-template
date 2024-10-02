# Builds the Backdash API documentation using docfx

$prevPwd = $PWD; Set-Location -ErrorAction Stop -LiteralPath $PSScriptRoot

try {
  $PWD  # output the current location

  dotnet tool install -g docfx

  # Force delete metadata
  Remove-Item ./_site -Recurse -Force -ErrorAction SilentlyContinue

  $env:DOCFX_SOURCE_BRANCH_NAME = "master"

  docfx --serve
}
finally {
  # Restore the previous location.
  $prevPwd | Set-Location
}
