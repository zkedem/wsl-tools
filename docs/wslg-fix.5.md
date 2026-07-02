# NAME

wslg-fix - ensure write access to X11 socket for WSLg

# SYNOPSIS

**wslg-fix.service**  
**/etc/init.d/wslg-fix** { **start** \| **stop** \| **restart** \|
**force-reload** \| **status** }

# DESCRIPTION

The X Window System, Version 11 (X11) makes use of UNIX domain sockets
(see the **unix**(7) manual page) whenever a client application is to
run on the same machine as its display server. These sockets are
accessible as files stored in the directory _/tmp/.X11-unix_. Under the
Windows Subsystem for Linux GUI (WSLg), this directory is set as
read-only by default, which prevents more sophisticated applications,
such as desktop environments, from working. **wslg-fix** automatically
recreates _/tmp/.X11-unix_ upon startup, sets the correct access
permissions for it and the Wayland lock file, and links the sockets to
those used by WSLg.

**wslg-fix** should be enabled by default on all systems. If this is not
the case, and your operating system uses systemd, run '**systemctl
enable wslg-fix**'.

# SEE ALSO

**wsl-tools-services**(5)
