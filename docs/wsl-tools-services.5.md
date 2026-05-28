# NAME

wsl-tools-services - service units provided by wsl-tools

# SYNOPSIS

**keepwsl.service**, **wslg-fix.service**,
**user-runtime-dir@.service.d**

# DESCRIPTION

For systemd-based operating systems, wsl-tools includes service units
that help facilitate its core functions. These are:

**keepwsl.service**  
Keeps the Windows Subsystem for Linux (WSL) running when a desktop
environment or graphical session is in use. Needed when full desktop
environments with display managers are to be used.

**wslg-fix.service**  
Ensures proper write access to the X11 socket used by the Windows
Subsystem for Linux GUI (WSLg). Needed by **Xwslg**(1) to function well.

In addition, wsl-tools modifies the user manager service unit (see
**user@.service**(5)) by adding the following lines:

    [Service]
    ExecStartPost=-/usr/bin/rm -f /run/user/%i/wayland-0 /run/user/%i/wayland-0.lock

# SEE ALSO

**user@.service**(5), **keepwsl.service**(5), **wslg-fix.service**(5)
