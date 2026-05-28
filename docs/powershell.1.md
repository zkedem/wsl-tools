# NAME

powershell - .NET command-line shell for Windows

# SYNOPSIS

**powershell** \[**-PSConsoleFile** *\<file\>* \| **-Version**
*\<version\>*\]  
\[**-NoLogo**\] \[**-NoExit**\] \[**-Sta**\] \[**-Mta**\]
\[**-NoProfile**\] \[**-NonInteractive**\]  
\[**-InputFormat** {**Text** \| **XML**}\] \[**-OutputFormat** {**Text**
\| **XML**}\]  
\[**-WindowStyle** *\<style\>*\] \[**-EncodedCommand**
*\<Base64EncodedCommand\>*\]  
\[**-ConfigurationName** *\<string\>*\]  
\[**-File** *\<filePath\>* *\<args\>*\] \[**-ExecutionPolicy**
*\<ExecutionPolicy\>*\]  
\[**-WorkingDirectory** *\<directoryPath\>*\]  
\[**-Command** { **-** \| *\<script-block\>* \[**-args**
*\<arg-array\>*\]  
\| *\<string\>* \[*\<CommandParameters\>*\] } \]  
\[**-WslPSConsoleFile** *\<file\>*\]  
\[**-WslFile** *\<filePath\>* *\<args\>*\]  
\[**-WslWorkingDirectory** *\<directoryPath\>*\]

**powershell** **-Help** \| **-?** \| **/?**

# DESCRIPTION

Windows PowerShell is a command-line shell, scripting language, and
automation platform built on the .NET Framework and powered by the
Common Language Runtime (CLR). As such, it allows nearly complete access
to the full feature set of the .NET Framework and Windows, including
system calls. The **powershell** utility allows Windows PowerShell to be
utilized from within the Windows Subsystem for Linux (WSL), providing
enhanced integration between the Windows and Linux environments.

# OPTIONS

The options are the same as for **PowerShell.exe** under Windows, with
extra options added to support WSL. All file and directory paths are
Windows paths unless otherwise specified.

**-PSConsoleFile** _file_  
Loads the specified Windows PowerShell console file. To create a
console  
file, use **Export-Console** in Windows PowerShell.

**-Version** _version_  
Starts the specified version of Windows PowerShell.  
Enter a version number with the parameter, such as "**-version** 2.0".

**-NoLogo**  
Hides the copyright banner at startup.

**-NoExit**  
Does not exit after running startup commands.

**-Sta**  
Starts the shell using a single-threaded apartment.  
Single-threaded apartment (STA) is the default.

**-Mta**  
Start the shell using a multithreaded apartment.

**-NoProfile**  
Does not load the Windows PowerShell profile.

**-NonInteractive**  
Does not present an interactive prompt to the user.

**-InputFormat** {**Text** \| **XML**}  
Describes the format of data sent to Windows PowerShell. Valid values
are  
"**Text**" (text strings) or "**XML**" (serialized CLIXML format).

**-OutputFormat** {**Text** \| **XML**}  
Determines how output from Windows PowerShell is formatted. Valid
values  
are "**Text**" (text strings) or "**XML**" (serialized CLIXML format).

**-WindowStyle** _style_  
Sets the window style to **Normal**, **Minimized**, **Maximized** or
**Hidden**.

**-EncodedCommand** _Base64EncodedCommand_  
Accepts a base-64-encoded string version of a command. Use this
parameter  
to submit commands to Windows PowerShell that require complex
quotation  
marks or curly braces.

**-ConfigurationName** _string_  
Specifies a configuration endpoint in which Windows PowerShell is run.  
This can be any endpoint registered on the local machine including the  
default Windows PowerShell remoting endpoints or a custom endpoint
having  
specific user role capabilities.

**-File** _filePath_ _args_  
Runs the specified script in the local scope ("dot-sourced"), so that
the  
functions and variables that the script creates are available in the  
current session. Enter the script file path and any parameters.  
File must be the last parameter in the command, because all characters  
typed after the File parameter name are interpreted  
as the script file path followed by the script parameters.

**-ExecutionPolicy** _ExecutionPolicy_  
Sets the default execution policy for the current session and saves it  
in the **\$env:PSExecutionPolicyPreference** environment variable.  
This parameter does not change the Windows PowerShell execution policy  
that is set in the registry.

**-Command** { **-** \| _script-block_ \[**-args** _arg-array_\] \| _string_ \[*CommandParameters*\] }  
Executes the specified commands (and any parameters) as though they
were  
typed at the Windows PowerShell command prompt, and then exits, unless  
**NoExit** is specified. The value of **Command** can be "**-**", a
string. or a  
script block.

If the value of **Command** is "**-**", the command text is read from
standard  
input.

If the value of **Command** is a script block, the script block must be
enclosed  
in braces ({}). You can specify a script block only when running
**PowerShell.exe**  
in Windows PowerShell. The results of the script block are returned to
the  
parent shell as deserialized XML objects, not live objects.

If the value of **Command** is a string, **Command** must be the last
parameter  
in the command , because any characters typed after the command are  
interpreted as the command arguments.

To write a string that runs a Windows PowerShell command, use the
format:  
**"& {***\<command\>***}"**  
where the quotation marks indicate a string and the invoke operator
(**&**)  
causes the command to be executed.

**-WorkingDirectory** _directoryPath_, **-wd** _directoryPath_  
Sets the working directory at the start of PowerShell given a valid
PowerShell directory path.  
Executing \`**Set-Location -LiteralPath** *\<path\>*\` at startup.  
Example: **pwsh -WorkingDirectory <span>~</span>**

**-Help**, **-?**, **/?**  
Displays a help message describing the options in this section.

**-WslPSConsoleFile** _file_  
Same as **-PSConsoleFile**, but takes a WSL path instead of a Windows
path.

**-WslFile** _filePath_ _args_  
Same as **-File**, but takes a WSL path instead of a Windows path.

**-WslWorkingDirectory** _directoryPath_, **-wslwd** _directoryPath_  
Same as **-WorkingDirectory**, but takes a WSL path instead of a Windows
path.

# NOTES

Windows PowerShell scripts that run from within WSL are supported. The
script should begin with the following line:

    #!/bin/env -S powershell -ExecutionPolicy Bypass -WslFile

Script files should have the _.ps1_ file extension.

# SEE ALSO

**execve**(2)
