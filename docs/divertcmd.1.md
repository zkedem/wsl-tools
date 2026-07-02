# NAME

divertcmd - override an existing command

# SYNOPSIS

**divertcmd** \[**-r**\] _fromcmd_ _tocmd_  
**divertcmd** **-h**

# DESCRIPTION

**divertcmd** diverts the command _fromcmd_ by renaming it to
'_fromcmd_.diverted', then creating a symbolic link to the command
_tocmd_ with the same name as the original _fromcmd_. Both _fromcmd_ and
_tocmd_ must be valid commands in the system's PATH or be given as
absolute file paths.

**divertcmd** provides a similar facility to **dpkg-divert**(1) on
Debian-based systems, except that it is packaging system- and operating
system-agnostic, and is focused solely on executable commands, not
configuration files or similar.

**Xwslg**(1) uses **divertcmd** to replace the distribution's default X
Window System server with itself.

# OPTIONS

**-h**  
Shows a help message.

**-r**  
Undo the diversion for _fromcmd_ and restore the original command.

# NOTES

**divertcmd**'s **-r** option works even if _tocmd_ has been uninstalled
or otherwise removed from the system.

# SEE ALSO

**Xwslg**(1), **dpkg-divert**(1)
