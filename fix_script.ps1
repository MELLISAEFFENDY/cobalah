# PowerShell script to fix Rayfield.Flags references
$content = Get-Content "mainv1.lua" -Raw
$content = $content -replace "Enum\.Material\[Rayfield\.Flags\['rodmaterial'\]\]", "Enum.Material[currentRodMaterial]"
$content = $content -replace "v\.Material ~= Enum\.Material\[Rayfield\.Flags\['rodmaterial'\]\]", "v.Material ~= Enum.Material[currentRodMaterial]"
$content = $content -replace "rod\['handle'\]\.Material ~= Enum\.Material\[Rayfield\.Flags\['rodmaterial'\]\]", "rod['handle'].Material ~= Enum.Material[currentRodMaterial]"
Set-Content "mainv1.lua" -Value $content
Write-Host "✅ Fixed all Rayfield.Flags['rodmaterial'] references!"
