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

function IsDeploymentTarget {
  param (
    [string]$TemplateFullName
  )
  # not target directory
  if ($TemplateFullName -match '\/CRML\/' -or $TemplateFullName -match '\/samples\/') {
    return $false
  }
  # definition templates
  if ($TemplateFullName -match 'resourceGroupLock.bicep') {
    return $false
  }

  return $true
}

function Deploy-BicepTemplate {
  param (
    [string]$Location = "japaneast",
    [parameter(mandatory=$true)]
    [bool]$ValidateMode
  )
  $subcmd = $ValidateMode ? "validate" : "create"

  Get-ChildItem -Recurse -Filter '*.bicep' -Exclude '.\infra-as-code\bicep\CRML\*','callModuleFromACR.example.bicep','orchHubSpoke.bicep', '' |
  Where-Object { IsDeploymentTarget -TemplateFullName $_.FullName } |
  ForEach-Object {
    Write-Information "==> Attempting Bicep Deploy For File: $_" -InformationAction Continue
    $bicepTemplateName = $_.BaseName
    $bicepTemplate = $_.FullName
    $parametersDirectory = "$($_.DirectoryName)\parameters"
    
    $commands = @()
    Get-ChildItem -Path $parametersDirectory -Recurse -Filter '*.bicepparam' -Exclude '*.sample.*.bicepparam' |
    ForEach-Object {
      Write-Information "==> Attempting Bicep Deploy For File: $bicepTemplate | Paramters: $_" -InformationAction Continue
      $timestamp = Get-Date -Format "yyyyMMddHHmmss"
      $bicepParametersName = $_.BaseName
      $deploymentName = "$bicepTemplateName-$bicepParametersName-$timestamp"
      $bicepParameters = $_.FullName
      $scope = Get-DeploymentScope -templatePath $bicepTemplate
      
      $command = "az deployment $scope $subcmd --name $deploymentName --location $Location --template-file $bicepTemplate --parameters $bicepParameters 2>&1"
      $commands += $command
    }

    $jobs = foreach ($command in $commands) {
      Start-job -ScriptBlock {
        param ($cmd)
        Invoke-Expression $cmd

        if ($LastExitCode -ne 0)
        {
          foreach ($item in $output) {
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
      } -ArgumentList $command
    }

    $jobs | ForEach-Object { $_ | Wait-Job}

    foreach ($job in $jobs) {
      $jobResult = Receive-Job -Job $job -ErrorAction SilentlyContinue
      if ($jobResult -is [System.Management.Automation.ErrorRecord]) {
        $errorMessage = $jobResult.Exception.Message
        $jobs | ForEach-Object { Remove-Job -Job $_ }
        throw $errorMessage
      }
    }

    $results = $jobs | ForEach-Object { Receive-Job -Job $_ }

    $jobs | ForEach-Object { Remove-Job -Job $_ }
    $results
  }
}