[CmdletBinding()]
param(
    [string]$DataFlexRoot = (Join-Path $env:ProgramFiles 'DataFlex 25.0')
)

$ErrorActionPreference = 'Stop'
$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
if (-not (Test-Path -LiteralPath (Join-Path $projectRoot 'FutbolWebApp.sws'))) {
    throw 'No se encuentra FutbolWebApp.sws en la carpeta del proyecto.'
}
$dataFlexPath = (Resolve-Path -LiteralPath $DataFlexRoot).Path
$initialData = Join-Path $dataFlexPath 'Usr\New\Data'
$webData = Join-Path $dataFlexPath 'Lib\WebAppMaster\Data'
foreach ($requiredPath in @($initialData, $webData, (Join-Path $dataFlexPath 'Lib\WebAppMaster\AppHtml'))) {
    if (-not (Test-Path -LiteralPath $requiredPath -PathType Container)) {
        throw "No se encuentra una instalacion completa de DataFlex 25.0: $requiredPath"
    }
}

foreach ($relativeFolder in @('AppSrc', 'Data', 'Programs', 'IdeSrc', 'Bitmaps', 'Help')) {
    $null = New-Item -ItemType Directory -Force -Path (Join-Path $projectRoot $relativeFolder)
}

# Copiar los juegos de tablas originales sin sustituir datos ya existentes.
$tableGroups = @(
    @{ Source = $initialData; Names = @('CodeMast', 'CodeType', 'DFLastId') },
    @{ Source = $webData; Names = @('WebAppUser', 'WebAppSession', 'WebAppServerProps') }
)
foreach ($tableGroup in $tableGroups) {
    foreach ($tableName in $tableGroup.Names) {
        $tablePattern = '^' + [regex]::Escape($tableName) + '\.(dat|hdr|k\d+|tag)$'
        foreach ($sourceFile in (Get-ChildItem -LiteralPath $tableGroup.Source -File | Where-Object Name -Match $tablePattern)) {
            $tableDestination = Join-Path (Join-Path $projectRoot 'Data') $sourceFile.Name
            if (-not (Test-Path -LiteralPath $tableDestination)) {
                Copy-Item -LiteralPath $sourceFile.FullName -Destination $tableDestination
            }
        }
    }
}

# El motor y los temas son dependencias de la instalacion, no codigo de la practica.
foreach ($assetFolder in @('DfEngine', 'CssThemes')) {
    $assetSource = Join-Path (Join-Path $dataFlexPath 'Lib\WebAppMaster\AppHtml') $assetFolder
    $assetDestination = Join-Path (Join-Path $projectRoot 'AppHtml') $assetFolder
    if (-not (Test-Path -LiteralPath $assetDestination)) {
        Copy-Item -LiteralPath $assetSource -Destination $assetDestination -Recurse
    }
}

# Generar las claves requeridas por los includes, manteniendo las existentes.
foreach ($keyName in @('LoginEncryptionKey.inc', 'WebAppEncryptionKey.inc')) {
    $keyPath = Join-Path (Join-Path $projectRoot 'AppSrc') $keyName
    if (-not (Test-Path -LiteralPath $keyPath)) {
        $randomBytes = New-Object byte[] 48
        $randomGenerator = [System.Security.Cryptography.RandomNumberGenerator]::Create()
        try { $randomGenerator.GetBytes($randomBytes) } finally { $randomGenerator.Dispose() }
        $randomKey = [Convert]::ToBase64String($randomBytes)
        $keySource = 'Set psEncryptPassword to "' + $randomKey + '"' + [Environment]::NewLine
        [System.IO.File]::WriteAllText($keyPath, $keySource, [System.Text.UTF8Encoding]::new($false))
    }
}

Write-Output 'Entorno local preparado. Las tablas y claves que ya existian se han conservado.'
