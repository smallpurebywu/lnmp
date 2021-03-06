Import-Module downloader
Import-Module unzip
Import-Module command
Import-Module cleanup

$lwpm=ConvertFrom-Json -InputObject (get-content $PSScriptRoot/lwpm.json -Raw)

$stable_version=$lwpm.version
$pre_version=$lwpm.'pre-version'
$github_repo=$lwpm.github
$homepage=$lwpm.homepage
$releases=$lwpm.releases
$bug=$lwpm.bug
$name=$lwpm.name
$description=$lwpm.description
$url=$lwpm.url
$pre_url=$lwpm.'pre-url'

Function install($VERSION=0,$isPre=0){
  if(!($VERSION)){
    $VERSION=$stable_version
  }
  if($isPre){
    $VERSION=$pre_version
  }

  $url=$url.replace('${VERSION}',${VERSION});

  $filename="PowerShell-${VERSION}-win-x64.msi"
  $unzipDesc="PowerShell"

  # _exportPath "$env:ProgramFiles\PowerShell\7-preview"

  _exportPath "$env:ProgramFiles\PowerShell\7"

  if($(_command pwsh)){
    $CURRENT_VERSION=(pwsh --version).split(" ")[1]

    if ($CURRENT_VERSION -eq $VERSION){
        "==> $name $VERSION already install"
        return
    }
  }

  # 下载原始 zip 文件，若存在则不再进行下载

  _downloader `
    $url `
    $filename `
    $name `
    $VERSION

  # 验证原始 zip 文件 Fix me

  # 解压 zip 文件 Fix me
  # _cleanup ""
  # _unzip $filename $unzipDesc

  # 安装 Fix me
  # Copy-item -r -force "" ""
  Start-Process -FilePath $filename

  # https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-windows?view=powershell-7#administrative-install-from-the-command-line
  # https://docs.microsoft.com/en-us/windows/win32/msi/command-line-options
  # msiexec.exe /package $filename `
  #  /quiet `
  #  ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 `
  #  ENABLE_PSREMOTING=1 `
  #  REGISTER_MANIFEST=1

  # _cleanup ""

  # [environment]::SetEnvironmentvariable("", "", "User")
  # _exportPath "$env:ProgramFiles\PowerShell\7-preview"

  _exportPath "$env:ProgramFiles\PowerShell\7"

  # "==> Checking ${name} ${VERSION} install ..."
  # 验证 Fix me
  # pwsh --version
}

Function uninstall(){
  "Not Support"
}
