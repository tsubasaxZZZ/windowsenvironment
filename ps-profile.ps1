if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Emacs
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
}

# Git 管理ディレクトリ
function git_branch {
    git branch 2>$null |
    where { -not [System.String]::IsNullOrEmpty($_.Split()[0]) } |
    % { $bn = $_.Split()[1]
        Write-Output "($bn)" }
}

function gh {
    $env:GHQ_ROOT="C:\ghq"
    cd $(ghq.exe list -p | peco.exe)
}

# プロンプト表示を変更する
function prompt {
    # カレントディレクトリをウィンドウタイトルにする
    (Get-Host).UI.RawUI.WindowTitle = "Windows PowerShell " + $pwd
 
    # GitBashっぽく表示
    # カレントディレクトリを取得
    $idx = $pwd.ProviderPath.LastIndexof("\") + 1
    $cdn = $pwd.ProviderPath.Remove(0, $idx)
 
    # 現在時刻を取得
    $t = (Get-Date).ToLongTimeString()
 
    # ブランチ名を取得
    $gitBranch = git_branch
    #$hgBranch = hg_branch
 
    # プロンプトをセット
    Write-Host "[" -NoNewline -ForegroundColor White
    Write-Host "$t " -NoNewline -ForegroundColor Green
    # Write-Host $env:USERNAME -NoNewline -ForegroundColor Cyan
    # Write-Host "@$env:USERDOMAIN " -NoNewline -ForegroundColor White
    # Write-Host "$gitBranch " -NoNewline -ForegroundColor Yellow
    Write-Host "${pwd}" -NoNewline -ForegroundColor Cyan
    Write-Host "$gitBranch" -NoNewline -ForegroundColor Yellow
    Write-Host "]
 $" -NoNewline -ForegroundColor White
    return " "
 }
