# NAME

Xwslg - an X server for WSLg

# SYNOPSIS

**Xwslg** \[option ...\]

# DESCRIPTION

**Xwslg** is an X server launcher for the Windows Subsystem for Linux
GUI (WSLg) that uses **Xwayland** as its backend. It is meant as a
replacement for the **Xorg** X server.

# OPTIONS

**Xwslg** accepts all the command line options described in the
**Xserver**(1) and **Xwayland**(1) manual pages, as well as the
**-config** and **-configdir** options of **Xorg**(1). The following
options are also supported:

**-divert** _cmd_  
Divert a command to **Xwslg**. This means that, when you attempt to run
_cmd_, **Xwslg** will be called instead. The command should take the
same options/arguments as a typical X server.

In most cases, if you have installed wsl-tools from your package
manager, **Xorg** will be diverted to **Xwslg** by default. If not, you
can run '**Xwslg -divert Xorg**'.

The original command will still be available as '_cmd_.diverted'.

**-parse** _section_\[**.**_subsection_\|**@**_mode_\] \[*id*\]  
Parse a configuration file specified with the **-config** option, then
exit. This dumps **Xwslg**'s internal parser model of the given section
of the file to standard output, which can be useful for debugging.

A specific instance of a section may be selected with _id_, which may be
either a number or the value of an **Identifier** entry (see the
**xwslg.conf**(5) manual page).

Subsections and modes within a section instance can also be dumped.
Subsections can be selected with a period (**.**), and modes can be
selected with a commercial at (**@**). For instance,
'**Screen.Display**' dumps the **Display** subsection of a **Screen**
section, and '**Monitor@1920x1080_60**' dumps the **1920x1080_60** mode
description from a **Monitor** section.

**-restore** _cmd_  
Restore a command previously diverted to **Xwslg** with the **-divert**
option.

Furthermore, the display number option (**:**) described in the
**Xserver**(1) manual page is modified as follows:

**:**_displaynumber_  
**Xwslg** runs as the given _displaynumber_, which by default is 0. If
multiple X servers are to run simultaneously on a host, each must have a
unique display number. If a display number is already taken, **Xwslg**
will automatically select the next available display number. See the
DISPLAY NAMES section of the **X**(7) manual page to learn how to
specify which display number clients should try to use.

# ENVIRONMENT

**XWSLGCONFIG**  
absolute path to configuration file for "root" user; relative path to
configuration file for regular users; see **xwslg.conf**(5) for more
information.

# CONFIGURATION

**Xwslg** makes use of a configuration file called _xwslg.conf_ and
configuration files with the suffix _.conf_ in a directory called
_xwslg.conf.d_ for its initial setup. Refer to the **xwslg.conf**(5)
manual page for information about the format of this file.

If no _xwslg.conf_ file or _xwslg.conf.d_ files are present, **Xwslg**
assumes the same default settings as **Xwayland**.

# FILES

**Xwslg** config files can be found in a range of locations. These are
documented fully in the **xwslg.conf**(5) manual page. Some common
locations are shown here.

**/etc/X11/xwslg.conf**  
**Xwslg** configuration file.

**/etc/xwslg.conf**  
**Xwslg** configuration file.

**/usr/etc/xwslg.conf**  
**Xwslg** configuration file.

**/usr/lib/X11/xwslg.conf**  
**Xwslg** configuration file.

**/etc/X11/xwslg.conf.d**  
**Xwslg** configuration directory.

**/etc/xwslg.conf.d**  
**Xwslg** configuration directory.

**/usr/etc/xwslg.conf.d**  
**Xwslg** configuration directory.

**/usr/lib/X11/xwslg.conf.d**  
**Xwslg** configuration directory.

# SEE ALSO

**Xorg**(1), **Xserver**(1), **Xwayland**(1), **xwslg.conf**(5),
**X**(7)
