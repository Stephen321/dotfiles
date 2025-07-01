Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# install WezTerm (could use winget..)
# install rustup from website 
winget install fzf sharkdp.fd lazygit dandavision.delta wezterm zoxide lsd-rs.lsd BurntSushi.ripgrep.MSVC JesseDuffield.lazygit
Install-Module -Name PowerShellGet -Force
Install-Module -Name PSFzf 
Install-Module lsd-aliases -Scope CurrentUser -AllowClobber
$cargo_dependencies = Get-Content -Path ../cargo_dependencies
cargo install $cargo_dependencies
