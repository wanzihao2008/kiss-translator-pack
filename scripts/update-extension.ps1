<#
.SYNOPSIS
    把 extension/ 里的扩展包更新到最新上游版本，并刷新 SHA256SUMS.txt。

.DESCRIPTION
    用法（在仓库根目录执行）：
        powershell -ExecutionPolicy Bypass -File .\scripts\update-extension.ps1
        powershell -ExecutionPolicy Bypass -File .\scripts\update-extension.ps1 -Version v2.2.2 -Channel edge

    说明：
    - 直连 GitHub 太慢时，可加 -Mirror https://gh-proxy.com/ 走镜像；
      下载完会用 GitHub 官方提供的 SHA-256 校验，镜像不影响完整性。
    - 不会提交任何东西，改完你自己 git add / commit。
#>
[CmdletBinding()]
param(
    [string]$Version = "latest",
    [ValidateSet("edge", "chrome", "firefox")]
    [string]$Channel = "edge",
    [string]$Mirror = ""
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$extDir = Join-Path $repoRoot "extension"
New-Item -ItemType Directory -Force -Path $extDir | Out-Null

# 解析版本
if ($Version -eq "latest") {
    $rel = Invoke-RestMethod "https://api.github.com/repos/fishjar/kiss-translator/releases/latest" `
        -Headers @{ "User-Agent" = "kiss-pack-updater" }
    $Version = $rel.tag_name
}

$base = "https://github.com/fishjar/kiss-translator/releases/download/$Version"
$name = "kiss-translator_$($Version)_$Channel.zip"
$url = "$base/$name"
$dest = Join-Path $extDir $name

Write-Host "版本: $Version  通道: $Channel"
Write-Host "下载: $url"

# 取官方校验值（release body 里没有，用 API 的 digest 字段；没有就跳过校验并提醒）
$expected = $null
try {
    $asset = (Invoke-RestMethod "https://api.github.com/repos/fishjar/kiss-translator/releases/tags/$Version" `
        -Headers @{ "User-Agent" = "kiss-pack-updater" }).assets |
        Where-Object { $_.name -eq $name }
    if ($asset.digest) { $expected = ($asset.digest -replace '^sha256:', '') }
} catch {
    Write-Warning "取官方 digest 失败，将跳过校验：$($_.Exception.Message)"
}

if ($Mirror) { $url = $Mirror.TrimEnd('/') + '/' + $url }

Invoke-WebRequest $url -OutFile $dest -UseBasicParsing

$hash = (Get-FileHash $dest -Algorithm SHA256).Hash.ToLower()
Write-Host "SHA-256: $hash"

if ($expected) {
    if ($hash -ne $expected.ToLower()) {
        Remove-Item $dest -Force
        throw "校验失败！期望 $expected，实际 $hash，已删除下载文件。"
    }
    Write-Host "校验通过 ✓" -ForegroundColor Green
} else {
    Write-Warning "没有官方校验值，请自行核对。"
}

"$hash  $name" | Set-Content -Path (Join-Path $extDir "SHA256SUMS.txt") -Encoding ASCII
Write-Host "已写入 extension/SHA256SUMS.txt"
Write-Host "记得把 README 里「版本与校验」表格一起更新。"
