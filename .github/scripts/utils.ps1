function Get-DeploymentScope {
  param (
    [string]$templatePath
  )

  if ($templatePath -match '\/modules\/managementGroups\/') {
    return "tenant"
  }
  if ($templatePath -match '\/modules\/subscriptionPlacement\/') {
    return "mg"
  }
  if ($templatePath -match '\/modules\/resourceGroup') {
    return "sub"
  }
  return "group"
}

function Deploy-BicepTemplate {
  param (
    [string]$Location = "japaneast",
    [parameter(mandatory=$true)]
    [bool]$ValidateMode
  )
  $subcmd = $ValidateMode ? "validate" : "create"

  Get-ChildItem -Recurse -Filter '*.bicep' -Exclude '.\infra-as-code\bicep\CRML\*','callModuleFromACR.example.bicep','orchHubSpoke.bicep', '' |
  Where-Object { $_.FullName -notmatch '\/CRML\/' -and $_.FullName -notmatch '\/samples\/' } |
  ForEach-Object {
    Write-Information "==> Attempting Bicep Deploy For File: $_" -InformationAction Continue
    $bicepTemplate = $_.FullName
    $parametersDirectory = "$($_.DirectoryName)\parameters"
    Get-ChildItem -Path $parametersDirectory -Recurse -Filter '*.bicepparam' -Exclude '*.sample.*.bicepparam' |
    ForEach-Object {
      Write-Information "==> Attempting Bicep Deploy For File: $bicepTemplate | Paramters: $_" -InformationAction Continue
      $bicepParameters = $_.FullName
      $scope = Get-DeploymentScope -templatePath $bicepTemplate
      $bicepOutput = @()
      $command = "az deployment $scope $subcmd --location $Location --template-file $bicepTemplate --parameters @$bicepParameters 2>&1"
      # $bicepOutput = az deployment sub create --template-file $bicepTemplate --parameters @$bicepParameters 2>&1
      $bicepOutput = Invoke-Command $command
      if ($LastExitCode -ne 0)
      {
        foreach ($item in $bicepOutput) {
          $output += "$($item) `r`n"
        }
      }
      Else
      {
        Write-Host "Bicep deploy Successful for File: $bicepTemplate"
      }

      if ($output.length -gt 0) {
        throw $output
      }
    }
  }
}