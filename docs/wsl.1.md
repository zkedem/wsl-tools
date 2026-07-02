# NAME

wsl - launches WSL instance from within WSL

# SYNOPSIS

**wsl** \[*Argument*\] \[*Options*...\] \[*CommandLine*\]

# DESCRIPTION

The Windows Subsystem for Linux (WSL) enables Linux programs to run on
Windows under a virtualized Linux operating system. WSL is invoked and
managed using the **wsl.exe** command in Windows. At times, it may be
advantageous to manage/invoke WSL from within WSL itself. The **wsl**
command is a wrapper script that calls Windows' **wsl.exe** for this
purpose.

# OPTIONS

The options described here are largely the same as for **wsl.exe** under
Windows, with a few extra. Under WSL, most of these options are
unavailable for regular users, apart from **--list**, **--status**, and
**--version**; otherwise, it would be possible to run commands as root
without entering a password. Any file path arguments must be Windows
paths unless otherwise noted. These options may be reviewed at any time
using '**wsl --help**'.

## Arguments for running Linux binaries:

If no command line is provided, **wsl** launches the default shell.

**--exec**, **-e** \<_CommandLine_\>  
Execute the specified command without using the default Linux shell.

**--shell-type** \<**standard**\|**login**\|**none**\>  
Execute the specified command with the provided shell type.

**--**  
Pass the remaining command line as-is.

## Options:

**--cd** \<_Directory_\>  
Sets the specified directory as the current working directory.  
If <span>~</span> is used the Linux user's home path will be used. If
the path begins  
with a / character, it will be interpreted as an absolute Linux path.  
Otherwise, the value must be an absolute Windows path.

**--distribution**, **-d** \<_DistroName_\>  
Run the specified distribution.

**--distribution-id** \<_DistroGuid_\>  
Run the specified distribution ID.

**--user**, **-u** \<_UserName_\>  
Run as the specified user.

**--system**  
Launches a shell for the system distribution.

## Arguments for managing Windows Subsystem for Linux:

**--help**  
Display usage information.

**--debug-shell**  
Open a WSL2 debug shell for diagnostics purposes.

**--install** \[*Distro*\] \[*Options*...\]  
Install a Windows Subsystem for Linux distribution.  
For a list of valid distributions, use '**wsl --list** **--online**'.

&nbsp;&nbsp;&nbsp;&nbsp; Options:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--enable-wsl1**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Enable WSL1 support.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--fixed-vhd**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Create a fixed-size
disk to store the distribution.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--from-file**
\<_Path_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Install a distribution
from a local file.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--legacy**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Use the legacy
distribution manifest.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--location**
\<_Location_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Set the install path
for the distribution.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--name** \<_Name_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Set the name of the
distribution.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--no-distribution**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Only install the
required optional components, does not install a distribution.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--no-launch**,
**-n**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Do not launch the
distribution after install.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--version**
\<_Version_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Specifies the version
to use for the new distribution.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--vhd-size**
\<_MemoryString_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Specifies the size of
the disk to store the distribution.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--web-download**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Download the
distribution from the internet instead of the Microsoft Store.

**--manage** \<_Distro_\> \<_Options_...\>  
Changes distro specific options.

&nbsp;&nbsp;&nbsp;&nbsp; Options:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--move**
\<_Location_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Move the distribution
to a new location.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--set-sparse**,
**-s** \<**true**\|**false**\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Set the vhdx of distro
to be sparse, allowing disk space to be automatically reclaimed.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--set-default-user**
\<_Username_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Set the default user
of the distribution.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--resize**
\<_MemoryString_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Resize the disk of the
distribution to the specified size.

**--mount** \<_Disk_\>  
Attaches and mounts a physical or virtual disk in all WSL 2
distributions.

&nbsp;&nbsp;&nbsp;&nbsp; Options:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--vhd**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Specifies that
\<_Disk_\> refers to a virtual hard disk.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--bare**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Attach the disk to
WSL2, but don't mount it.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--name** \<_Name_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Mount the disk using a
custom name for the mountpoint.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--type** \<_Type_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Filesystem to use when
mounting a disk, if not specified defaults to ext4.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--options**
\<_Options_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Additional mount
options.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--partition**
\<_Index_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Index of the partition
to mount, if not specified defaults to the whole disk.

**--set-default-version** \<_Version_\>  
Changes the default install version for new distributions.

**--shutdown**  
Immediately terminates all running distributions and the WSL 2
lightweight utility virtual machine.

**--status**  
Show the status of Windows Subsystem for Linux.

**--unmount** \[*Disk*\]  
Unmounts and detaches a disk from all WSL2 distributions.  
Unmounts and detaches all disks if called without argument.

**--uninstall**  
Uninstalls the Windows Subsystem for Linux package from this machine.

**--update**  
Update the Windows Subsystem for Linux package.

&nbsp;&nbsp;&nbsp;&nbsp; Options:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--pre-release**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Download a pre-release
version if available.

**--version**, **-v**  
Display version information.

## Arguments for managing distributions in Windows Subsystem for Linux:

**--export** \<_Distro_\> \<_FileName_\> \[*Options*\]  
Exports the distribution to a tar file.  
The filename can be - for stdout.

&nbsp;&nbsp;&nbsp;&nbsp; Options:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--format**
\<_Format_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Specifies the export
format. Supported values: tar, tar.gz, tar.xz, vhd.

**--import** \<_Distro_\> \<_InstallLocation_\> \<_FileName_\> \[*Options*\]  
Imports the specified tar file as a new distribution.  
The filename can be - for stdin.

&nbsp;&nbsp;&nbsp;&nbsp; Options:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--version**
\<_Version_\>

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Specifies the version
to use for the new distribution.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--vhd**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Specifies that the
provided file is a .vhdx file, not a tar file.  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; This operation makes a
copy of the .vhdx file at the specified install location.

**--import-in-place** \<_Distro_\> \<_FileName_\>  
Imports the specified .vhdx file as a new distribution.  
This virtual hard disk must be formatted with the ext4 filesystem type.

**--list**, **-l** \[*Options*\]  
Lists distributions.

&nbsp;&nbsp;&nbsp;&nbsp; Options:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--all**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; List all
distributions, including distributions that are currently being
installed or uninstalled.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--running**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; List only
distributions that are currently running.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--quiet**, **-q**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Only show distribution
names.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--verbose**, **-v**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Show detailed
information about all distributions.

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **--online**, **-o**

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Displays a list of
available distributions for install with '**wsl --install**'.

**--set-default**, **-s** \<_Distro_\>  
Sets the distribution as the default.

**--set-version** \<_Distro_\> \<_Version_\>  
Changes the version of the specified distribution.

**--terminate**, **-t** \<_Distro_\>  
Terminates the specified distribution.

**--unregister** \<_Distro_\>  
Unregisters the distribution and deletes the root filesystem.

## Additional arguments:

**--terminate-self**  
Terminate the current distribution.  
This is the same as specifying '**-t Ubuntu**' under Ubuntu, for
example.

**--this-distribution**  
Run another instance of the current distribution.
