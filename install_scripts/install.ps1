Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop bucket add extras
scoop install zig fzf fd uv lazygit
Install-Module -Name PowerShellGet -Force
Install-Module -Name PSFzf 
Install-Module lsd-aliases -Scope CurrentUser -AllowClobber
$cargo_dependencies = Get-Content -Path ../cargo_dependencies
cargo install $cargo_dependencies
