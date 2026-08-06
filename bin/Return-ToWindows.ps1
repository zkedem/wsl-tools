#!/bin/env -S powershell -ExecutionPolicy Bypass -WslFile

$distro = $PWD.Path.Split([IO.Path]::DirectorySeparatorChar)[4]
$fsroot = "\\wsl.localhost\$distro"
$sources = "User32.cs"

foreach ($directory in "$fsroot\usr\lib", "$fsroot\usr\local\lib")
{
	foreach ($file in $sources)
	{
		if (Test-Path "$directory\$file" -PathType Leaf)
		{
			Add-Type -TypeDefinition $(Get-Content "$directory\$file" -Raw)
		}
	}
}

while ([User32]::EnumWindows([User32+WNDENUMPROC] {
	param([IntPtr] $hwnd, [IntPtr] $lParam)
	$wpid = [UInt32]::new()
	[Void] [User32]::GetWindowThreadProcessId($hwnd, [ref] $wpid)
	if ((Get-Process -Id $wpid).ProcessName -eq "msrdc")
	{
		$wtext = [Text.StringBuilder]::new([User32]::GetWindowTextLength($hwnd))
		[Void] [User32]::GetWindowText($hwnd, $wtext, $wtext.Capacity + 1)
		if ($wtext.ToString() -match "^(\[.*\] )?(top-level window|Xwayland on :[0-9]+) \($distro\)$")
		{
			# WM_SYSCOMMAND, SC_MINIMIZE
			[Void] [User32]::SendMessage($hwnd, 0x0112, [UIntPtr]::new(0xF020), [IntPtr]::Zero)
			return $false
		}
	}
	return $true
}, [IntPtr]::Zero))
{}
