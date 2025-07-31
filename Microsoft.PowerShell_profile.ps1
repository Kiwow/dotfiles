New-Alias -Name clr -Value clear
New-Alias -Name tm -Value taskmgr
New-Alias -Name vim -Value nvim

Remove-Alias -Name cat
New-Alias -Name cat -Value bat

function whichcolor {
    param ($color)
    bun run "C:\Users\matya\Desktop\lilscripts\whichcolor\index.js" $color
}

function work {
    bun run "C:\Users\matya\work\index.ts" $args
}

function file {
    param ($path)
    get-item $path | format-list
}

function mkd {
    param ($path)
    (mkdir $path) -and (cd $path) | out-null
}

Remove-Alias -Name ls
function ls {
    # Icons unfortunately don't show up in the default JetBrains Mono font
    eza --color=automatic --group-directories-first --icons=never $args
}

Remove-Alias -Name history
function history {
    cat (Get-PSReadlineOption).HistorySavePath
}

function gst { git status $args }
function gsw { git switch $args }
function gco { git commit $args }
function gbr { git branch $args }
function gfe { git fetch $args }
function gll { git log --oneline --graph --all --decorate $args }
function gl { git log --oneline --decorate $args }
function glnm { git log --oneline --decorate --no-merges $args }
function gsh { git show --stat --abbrev-commit $args }
function ga { git add $args }
function gap { git add -p $args }
function gd { git diff $args }
function gdc { git diff --cached $args }
function gre { git restore $args }
function gres { git restore --staged $args }

# Agi's shortcuts
function gagi { git commit $args }
function glo { git log --oneline --decorate $args }
function glog { git log --oneline --graph --all --decorate $args }
function gas { git push $args }
function gitgud { git branch $args }
function gwassup { git status $args }
function gg { git reset $args }
function great { git restore $args }
function grr { git revert $args } 

$env:Path += ";C:\Program Files\Google\Chrome\Application"
$env:Path += ";C:\Users\matya\AppData\Local\Programs\Python\Python313"
$env:Path += ";C:\Users\matya\Documents\lazygit\lazygit_0.42.0_Windows_x86_64"
$env:Path += ";C:\Users\matya\Documents\yt-dlp"
$env:Path += ";C:\Users\matya\Documents\ffmpeg_for_yt_dlp\ffmpeg-master-latest-win64-gpl\bin"
$env:Path += ";C:\Users\matya\Documents\php"
$env:Path += ";C:\Users\matya\Documents\less"

# zed
$env:Path += ";C:\Users\matya\zed\target\release"
$env:Path += ";C:\Users\matya\zed-patched"

# neovim/nvim things
$env:EDITOR = "nvim"
$env:Path += ";C:\Users\matya\neovim-release\bin"
$env:Path += ";C:\Users\matya\lua_ls\bin"

# Deels
function astudio {
    & 'C:\Users\matya\Desktop\Android Studio.lnk'
}

$env:BAT_THEME = "Catppuccin Mocha"

# Not needed since starship does it
# Import-Module posh-git

Invoke-Expression (&starship init powershell)

function red($s) {
    # Catppuccin Mocha Red (#f38ba8)
    "`e[38;2;243;139;168m$($s)`e[0m"
}

function green($s) {
    # Catppuccin Mocha Green (#a6e3a1)
    "`e[38;2;166;227;161m$($s)`e[0m"
}

# custom prompt
function _prompt {
    $origLastExitSuccess = $?
    $origLastExitCode = $LASTEXITCODE

    $currentPath = "$($ExecutionContext.SessionState.Path.CurrentLocation)"
    if ($currentPath.startsWith($Home)) {
	# alias home path as ~
	$currentPath = "~" + $currentPath.SubString($Home.Length)
    }
    $prompt = $currentPath

    # if in a git repo
    if ($status = Get-GitStatus -Force) {
	# indicator of state compared to remote, if there is a remote
	if ($branchStatus = $(Write-GitBranchStatus $status)) {
	    $prompt += $branchStatus
	}

	$prompt += "$(Write-GitBranchName $status) "

	# working tree state
	if ($status.HasWorking) {
	    $prompt += red "~"
	}
	if ($status.HasWorking -and $status.HasIndex) {
	    $prompt += " "
	}
	# index state
	if ($status.HasIndex) {
	    $prompt += green "~"
	}
    }

    $commandPrefix = "$(if ($PsDebugContext) {' [DBG]:'} else {''})`n$('>' * ($nestedPromptLevel + 1)) "
    $prompt += if ($origLastExitSuccess) {
	# it would be good to also check for $origLastExitCode here,
	# but a lot of PowerShell commands don't set it, so you end up
	# with false negatives (wrongly reported exit errors)
	green $commandPrefix
    } else {
	red $commandPrefix
    }

    $LASTEXITCODE = $origLastExitCode
    $prompt
}
