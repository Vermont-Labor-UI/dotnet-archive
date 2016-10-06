$build = (Get-Content .\build.json | Out-String | ConvertFrom-Json)
if ($build.deploys)
{
  Add-Type -Assembly System.IO.Compression.FileSystem
  $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
  $build.deploys | ForEach {
    $directory = $Build.ArtifactStagingDirectory + "/" + $_.name;
    $output = $Build.ArtifactStagingDirectory + "/artifacts/" + $_.name + ".zip"
    [System.IO.Compression.ZipFile]::CreateFromDirectory($directory, $output, $compressionLevel, $false)
    Write-Host "Created Zip $output"
  }
}
else
{
  Write-Host "No deploy packages to archive."
}
