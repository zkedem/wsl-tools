# NAME

Get-WindowsEnv.ps1 - Accesses Windows environment variables from WSL

# SYNOPSIS

**Get-WindowsEnv.ps1** \[**-Posix**\] \[**-LowerCase**\]
\[\[**-Prefix**\] _prefix_\] \[**-Name** _name_\]  
**Get-WindowsEnv.ps1** **-Help**

# DESCRIPTION

**Get-WindowsEnv.ps1** is a Windows Powershell script that writes
enivronment variables from Windows to standard output, similarly to the
**env**(1) or **set** commands. It allows Windows environment variables
to be accessed and read from within the Windows Subsystem for Linux
(WSL), though it does not allow those variables to be modified. Variable
names and values can be output in a format suitable for input to
**sh**(1) and other common shells.

# OPTIONS

**-Help**  
Show a help message.

**-Posix**  
Output variable names in a format acceptable to POSIX **sh** for input,
using only the 26 letters of the basic Latin alphabet in upper and lower
case, digits, and underscores. Common punctuation marks which are
allowed in Windows variable names are replaced with underscores, so
"**ProgramFiles(x86)**" becomes "**ProgramFiles_x86\_**", for example.

**-LowerCase**  
Output variable names in lower case. Because Windows treats variable
names case-insensitively while also preserving the case with which they
were originally defined, this can help prevent name conflicts if the
variables are to be imported by a shell script.

**-Prefix** _prefix_  
Only output variables whose names begin with the given prefix.

**-Name** _name_  
Only output the variable whose name matches the given name. This option
overrides **-Prefix**.

# SEE ALSO

**env**(1), **powershell**(1), **sh**(1)
