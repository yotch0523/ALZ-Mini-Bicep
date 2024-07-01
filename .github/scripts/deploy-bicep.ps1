Get-ChildItem -Recurse -Filter '*.bicep' -Exclude '.\infra-as-code\bicep\CRML\*','callModuleFromACR.example.bicep','orchHubSpoke.bicep', '' | ForEach-Object {
  Write-Information "==> Attempting Bicep Deploy For File: $_" -InformationAction Continue
  $bicepTemplate = $_.FullName
  $parametersDirectory = "$_.DirectoryName\parameters"
  Get-ChildItem -Path $parametersDirectory -Recurse -Filter '*.bicepparam' -Exclude *.sample.*.bicepparam |
  Where-Object { $_.FullName -notmatch '\/CRML\/' } |
  ForEach-Object {
    Write-Information "==> Attempting Bicep Deploy For File: $bicepTemplate | Paramters: $_" -InformationAction Continue
    $bicepParameters = $_.FullName
    $bicepOutput = az deployment sub create --template-file $bicepTemplate --parameters @$bicepParameters 2>&1
    if ($LastExitCode -ne 0)
    {
      foreach ($item in $bicepOutput) {
        $output += "$($item) `r`n"
      }
    }
    Else
    {
      Write-Host "Bicep Build Successful for File: $bicepTemplate"
    }
  }
}