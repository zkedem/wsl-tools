#!/bin/env -S powershell -ExecutionPolicy Bypass -WslFile

param([switch] $Help, [switch] $Posix, [switch] $LowerCase, [String] $Prefix, [String] $Name)

if ($Help)
{
	[Console]::Error.Write("Usage: $($MyInvocation.MyCommand.Name) [-Posix] [-LowerCase] [[-Prefix] prefix] [-Name name]
   or: $($MyInvocation.MyCommand.Name) -Help
	-Help          Show this help message
	-Posix         Render variable names in POSIX-compliant format
	-LowerCase     Render variable names in lower case
	-Prefix prefix Only print variables whose names begin with the given prefix
	-Name name     Print only the variable whose name matches the given name
" -replace "`r", "")
	exit 1
}

foreach ($v in (Get-ChildItem Env:\))
{
	$Key = $v.Name
	if ($Posix)
	{
		$Key = $Key -creplace '\W', '_'
		$Prefix = $Prefix -creplace '\W', '_'
		$Name = $Name -creplace '\W', '_'
	}
	if ($LowerCase)
	{
		$Key = $Key.ToLowerInvariant()
		$Prefix = $Prefix.ToLowerInvariant()
		$Name = $Name.ToLowerInvariant()
	}
	if (!$Key.StartsWith($Prefix) -or (!!$Name -and $Key -cne $Name))
	{
		continue
	}
	[Console]::Write("$Key='$($v.Value)'`n")
}
