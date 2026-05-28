# NAME

xwslg.conf, xwslg.conf.d - configuration files for Xwslg

# INTRODUCTION

**Xwslg**, like **Xorg**, supports several mechanisms for supplying and
obtaining configuration and run-time parameters: command line options,
environment variables, the _xwslg.conf_ and _xwslg.conf.d_ configuration
files, auto-detection, and fallback defaults. When the same information
is supplied in more than one way, the highest precedence mechanism is
used. The list of mechanisms is ordered from highest precedence to
lowest. The available command line options and environment variables are
described in the **Xserver**(1), **Xorg**(1), **Xwayland**(1), and
**Xwslg**(1) manual pages. Configuration file parameters and default
values are described below.

# DESCRIPTION

The configuration files described here mostly follow the same format as
for **Xorg**, albeit with some differences. Hence, much of this page is
adapted from **xorg.conf**(5).

**Xwslg** uses a configuration file called _xwslg.conf_ and files ending
in the suffix _.conf_ from the directory _xwslg.conf.d_ for its initial
setup. The _xwslg.conf_ file is searched for in the following places
when **Xwslg** is started as a normal user:

&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/_\<cmdline\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/etc/X11/_\<cmdline\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/_**\$XWSLGCONFIG**  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/etc/X11/_**\$XWSLGCONFIG**  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/xwslg.conf_  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/xwslg.conf_  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/etc/X11/xwslg.conf._\<hostname\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/etc/X11/xwslg.conf_  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/lib/X11/xwslg.conf._\<hostname\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/lib/X11/xwslg.conf_  

where *\<cmdline\>* is a relative path specified with the **-config**
command line option, **\$XWSLGCONFIG** is the relative path specified by
that environment variable, and *\<hostname\>* is the machine's hostname
as reported by **uname**(1).

When **Xwslg** is started by the “root” user, the config file search
locations are as follows:

&nbsp;&nbsp;&nbsp;&nbsp; \<cmdline\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/_\<cmdline\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/etc/X11/_\<cmdline\>  
&nbsp;&nbsp;&nbsp;&nbsp; **\$XWSLGCONFIG**  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/_**\$XWSLGCONFIG**  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/etc/X11/_**\$XWSLGCONFIG**  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/xwslg.conf_  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/xwslg.conf_  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/etc/X11/xwslg.conf._\<hostname\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/etc/X11/xwslg.conf_  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/lib/X11/xwslg.conf._\<hostname\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/usr/lib/X11/xwslg.conf_  

where *\<cmdline\>* is the path specified with the **-config** command
line option (which may be absolute or relative), **\$XWSLGCONFIG** is
the relative path specified by that environment variable (absolute or
relative), **\$HOME** is the path specified by that environment variable
(usually the home directory), and *\<hostname\>* is the machine's
hostname as reported by **uname**(1).

Additional configuration files are searched for in the following
directories when **Xwslg** is started as a normal user:

&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/_\<cmdline\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/xwslg.conf.d_  

where *\<cmdline\>* is a relative path specified with the **-configdir**
command line option.

When **Xwslg** is started by the “root” user, the config directory
search locations are as follows:

&nbsp;&nbsp;&nbsp;&nbsp; \<cmdline\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/_\<cmdline\>  
&nbsp;&nbsp;&nbsp;&nbsp; _/etc/X11/xwslg.conf.d_  

where *\<cmdline\>* is the path specified with the **-configdir**
command line option (which may be absolute or relative).

Finally, configuration files will also be searched for in a directory
reserved for system use. These files are found in the following
directory:

&nbsp;&nbsp;&nbsp;&nbsp; _/usr/share/X11/xwslg.conf.d_  

The _xwslg.conf_ and _xwslg.conf.d_ files are composed of a number of
sections which may be present in any order, or omitted to use default
configuration values. Each section has the form:

&nbsp;&nbsp;&nbsp;&nbsp; **Section "**_SectionName_**"**  
&nbsp;&nbsp;&nbsp;&nbsp; _SectionEntry_  
&nbsp;&nbsp;&nbsp;&nbsp; ...  
&nbsp;&nbsp;&nbsp;&nbsp; **EndSection**  

Unlike **Xorg**, which recognizes several section names in its
configuration files, **Xwslg** recognizes only a few. The section names
recognized by **Xwslg** are:

&nbsp;&nbsp;&nbsp;&nbsp; **ServerFlags** Server flags  
&nbsp;&nbsp;&nbsp;&nbsp; **Extensions** Extension enabling  
&nbsp;&nbsp;&nbsp;&nbsp; **Vendor** Configuration options specific to
**Xwslg**  

If **Xwslg** encounters a section or entry name it does not recognize,
it will simply ignore it. Additional section and entry names may be
recognized in future releases.

Config file keywords are case-insensitive, and “\_” characters are
ignored. Most strings (including **Option** names) are also
case-insensitive, and insensitive to white space and “\_” characters.

Each config file entry usually takes up a single line in the file. They
consist of a keyword, which is possibly followed by one or more
arguments, with the number and types of the arguments depending on the
keyword. Like with section names, **Xwslg** recognizes fewer argument
types than **Xorg**, though this may change in future releases. The
argument types are:

&nbsp;&nbsp;&nbsp;&nbsp; **Integer** an integer number in decimal, hex
or octal  
&nbsp;&nbsp;&nbsp;&nbsp; **String** a string enclosed in double quote
marks (")  

Note: hex integer values must be prefixed with “0x”, and octal values
with “0”.

A special keyword called **Option** may be used to provide free-form
data to various components of the server. The **Option** keyword takes
either one or two string arguments. The first is the option name, and
the optional second argument is the option value. Valid option value
types include:

&nbsp;&nbsp;&nbsp;&nbsp; **Integer** an integer number in decimal, hex
or octal  
&nbsp;&nbsp;&nbsp;&nbsp; **String** a sequence of characters  
&nbsp;&nbsp;&nbsp;&nbsp; **Boolean** a boolean value (see below)  

Note that _all_ **Option** values, not just strings, must be enclosed in
quotes.

Boolean options may optionally have a value specified. When no value is
specified, the option's value is **TRUE**. The following boolean option
values are recognized as **TRUE**:

&nbsp;&nbsp;&nbsp;&nbsp; **1**, **on**, **true**, **yes**

and the following boolean option values are recognized as **FALSE**:

&nbsp;&nbsp;&nbsp;&nbsp; **0**, **off**, **false**, **no**

If an option name is prefixed with "**No**", then the option value is
negated.

Example: the following option entries are equivalent:

&nbsp;&nbsp;&nbsp;&nbsp; **Option "Accel" "Off"**  
&nbsp;&nbsp;&nbsp;&nbsp; **Option "NoAccel"**  
&nbsp;&nbsp;&nbsp;&nbsp; **Option "NoAccel" "On"**  
&nbsp;&nbsp;&nbsp;&nbsp; **Option "Accel" "false"**  
&nbsp;&nbsp;&nbsp;&nbsp; **Option "Accel" "no"**  

# SERVERFLAGS SECTION

This section is used to specify some global X server options. All of the
entries in this section are **Options**. The **ServerFlags** section is
optional, as are the entries that may be specified in it. Options with
command line equivalents are overridden when their command line
equivalent is used. The options recognized by this section are:

**Option "BlankTime" "**_time_**"**  
sets the inactivity timeout for the **blank** phase of the screensaver.
_time_ is in minutes. This is equivalent to **Xwslg**'s **-s** flag, and
the value can be changed at run-time with **xset**(1). Default: 10
minutes.

**Option "Xinerama" "**_boolean_**"**  
enable or disable XINERAMA extension. Default is disabled.

**Option "IndirectGLX" "**_boolean_**"**  
enable or disable indirect GLX contexts. Indirect GLX contexts are
disabled by default.

# EXTENSIONS SECTION

This section is used to specify which X11 protocol extensions should be
enabled or disabled. The **Extensions** section is optional, as are all
of the entries that may be specified in it.

Entries in this section are listed as **Option** statements with the
name of the extension as the first argument, and a boolean value as the
second. The extension name is case-sensitive, and matches the form shown
in the output of "**Xwslg -help**".

&nbsp;&nbsp;&nbsp;&nbsp; Example: the MIT-SHM extension can be disabled
with the following entry:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **Section
"Extensions"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Option
"MIT-SHM" "Disable"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **EndSection**  

# VENDOR SECTION

Traditionally, the **Vendor** section was used to provide
vendor-specific configuration information. Under **Xwslg**, the
**Vendor** section is used to specify default settings for **Xwslg** in
different contexts, and to pass options to the underlying **Xwayland**
instance. As such, the **Vendor** section may be present any number of
times, and contains an optional **Identifier** entry and any number of
**Option** flags.

The **Identifier** entry, if it is present, specifies the name of the
process that called **Xwslg**; in that case, the settings in the
respective **Vendor** section will only apply to those instances of
**Xwslg** whose parent process name matches that **Identifier** entry.
If no **Identifier** entry is present, the settings will apply to all
instances of **Xwslg** unless overridden by command line options. The
**Option** flags correspond to command line options of **Xwslg**, except
for the **Extend** flag which is explained below. The options recognized
by this section are:

**Option "Extend" "**_name_**"**  
inherits settings from another **Vendor** section that has an
**Identifier** entry matching _name_. This can be useful if you want the
same settings to apply in multiple contexts.

**Option "Rootless" "**_boolean_**"**  
enables or disables rootless mode, in which X clients are integrated
seamlessly with the Windows desktop. If this option is disabled, X
clients are displayed within a root window. Default is disabled.

**Option "Fullscreen" "**_boolean_**"**  
enables or disables fullscreen mode when running rootful. This option is
ignored if the system's version of **Xwayland** is older than 23.1.0, in
which case the root window will always be fullscreen. Otherwise, this
option is disabled by default.

**Option "Geometry" "**_WxH_**"**  
sets the size of the root window. This option is ignored when
**Fullscreen** is enabled, and is also ignored if the system's version
of **Xwayland** is older than 23.1.0. Default: 640x480.

**Option "HiDPI" "**_boolean_**"**  
adjusts to the output scale when running rootful. Default is disabled.

**Option "Host-Grab" "**_boolean_**"**  
activates host-grab mode, in which Windows keyboard shortcuts are
inhibited and the mouse pointer is confined to the root window. To leave
host-grab mode, press the \[CTRL\] and \[SHIFT\] keys together. Default
is disabled. This option is not supported when running rootless.

**Option "Keymap" "**_boolean_**"**  
uses the keymap set by WSLg's Wayland compositor when enabled. Disabling
this option allows X clients to select keymaps directly, which may be
preferable in certain cases. Default is enabled.

**Option "Output" "**_name_**"**  
specifies which output to use when running in fullscreen rootful mode.
Valid output names can be found using **wayland-info**(1). Under WSLg,
the default output is usually rdp-0.

**Option "WM" "**_fd_**"**  
specifies a socket for a window manager to connect to when **Xwslg** is
running in rootless mode. Unset by default.

**Option "InitFD" "**_fd_**"**  
specifies a listen socket to which X clients connect during
initialization. Unset by default.

**Option "ListenFD" "**_fd_**"**  
specifies a listen socket to which X clients connect. Unset by default.

**Option "Listen" "**_fd_**"**  
is a deprecated synonym for **ListenFD**. Unset by default.

**Option "SHM" "**_boolean_**"**  
forces the shared memory backend instead of the glamor backend for
passing buffers to WSLg's Wayland compositor. Default is disabled.

**Option "Glamor" "**_gl|es|off_**"**  
sets the rendering API to be used for Glamor acceleration. Valid values
are **gl** for the OpenGL API, which is the default, **es** for the GL
ES API, and **off**, which disables Glamor acceleration and has the same
effect as enabling the **SHM** option. This option cannot be specified
if the **SHM** option itself is enabled. Specifying this option requires
that your system's version of **Xwayland** support Glamor acceleration.

**Option "TouchPointerEmulation" "**_boolean_**"**  
enables or disables touch pointer emulation. Default is enabled.

**Option "Force-XRandR-Emulation" "**_boolean_**"**  
forces additional non-native modes to be exposed when the viewporter is
not supported by WSLg's Wayland compositor. Default is disabled.

**Option "Decorate" "**_boolean_**"**  
enables or disables decorations, i.e. caption buttons and window
borders, on the root window when running rootful. Default is disabled.
Specifying this option requires that libdecor be supported by your
system's version of **Xwayland**.

**Option "Enable-EI-Portal" "**_boolean_**"**  
activates the XDG portal for input emulation. Default is disabled.
Specifying this option requires that your system's version of
**Xwayland** have EI and OEFFIS support.

**Option "Clipboard" "**_boolean_**"**  
enables or disables the clipboard selection bridge, which syncs the X11
CLIPBOARD and PRIMARY selections with those of Wayland. Default is
disabled.

**Option "OtherOptions" "**_arg1_ _arg2_ ...**"**  
passes additional command line options to **Xwslg** if specified. These
may be any of the options listed in the output of '**Xwslg -help**'.

Examples:

&nbsp;&nbsp;&nbsp;&nbsp; Set the **-retro** option by default for all
instances of **Xwslg**:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **Section "Vendor"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Option
"OtherOptions" "-retro"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **EndSection**  

&nbsp;&nbsp;&nbsp;&nbsp; Run **Xwslg** in fullscreen if it was started
by **xinit**(1) (i.e. **startx**(1)):

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **Section "Vendor"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Identifier
"xinit"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Option
"Fullscreen" "Enable"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **EndSection**  

&nbsp;&nbsp;&nbsp;&nbsp; Apply the same settings for **xdm**(1) as for
**xinit**:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **Section "Vendor"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Identifier
"xdm"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Option
"Extend" "xinit"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **EndSection**  

&nbsp;&nbsp;&nbsp;&nbsp; Apply the same settings for **lightdm**(1) as
**xinit**, but also enable the **HiDPI** option:

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **Section "Vendor"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Identifier
"lightdm"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Option
"Extend" "xinit"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **&nbsp;Option
"HiDPI"**  
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; **EndSection**  

# NOTES

Special thanks to David Dawes *\<dawes<span>@</span>xfree86.org\>*,
without whose work _xwslg.conf_ and **Xwslg** wouldn't be possible.

# SEE ALSO

**Xorg**(1), **Xserver**(1), **Xwayland**(1), **Xwslg**(1),
**xorg.conf**(5)
