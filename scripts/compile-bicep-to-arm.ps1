param(
    $filePath,
    $bicepTemplate,
    $outFile
)

try{
    Write-Host "Compiling Bicep template to ARM template...."
    Write-Host "filePath: $filePath"
    Write-Host "bicepTemplate: $bicepTemplate"
    Write-Host "outFile: $outFile"
    Write-Host "............................................"
    az bicep upgrade
    az bicep build -f "${filePath}/${bicepTemplate}" -o "${filePath}/${outFile}"
    $files=Get-ChildItem -Path ${filePath}
    Write-Host "Show files..."
    Write-Host "${files}"
}catch{
    $message = $_.Exception.Message
    $stackTraceText = $_.Exception.StackTrace
    Write-Host "The script failed with the following text"
    Write-Host "${message}"
    Write-Host "Stack Trace"
    Write-Host "${stackTraceText}"
    throw "Script failed"
}