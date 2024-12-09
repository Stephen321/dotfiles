# Remove-Alias cat -Force -ErrorAction SilentlyContinue
# function cat {
# bat --paging=never
# }

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# example command - use $Location with a different command:
$commandOverride = [ScriptBlock]{ param($Location) z $Location }
# # pass your override to PSFzf:
Set-PsFzfOption -AltCCommand $commandOverride

# Alt-Tab starts to insert extra characters...annoying
# Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Set-PSReadLineKeyHandler -Key 'Ctrl+g' -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert('lazygit')
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
}
set FZF_DEFAULT_COMMAND="fd -type f"

(& uv generate-shell-completion powershell) | Out-String | Invoke-Expression
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
