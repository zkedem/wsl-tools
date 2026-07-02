# NAME

wsl-tools-services - services provided by wsl-tools

# SYNOPSIS

**keepwsl.service**, **wslg-fix.service**,
**user-runtime-dir<span>@</span>.service.d**  
**/etc/init.d/keepwsl**, **/etc/init.d/wslg-fix**

# DESCRIPTION

wsl-tools includes services that help facilitate its core functions.
These are:

**keepwsl.service**, **/etc/init.d/keepwsl**  
Keeps the Windows Subsystem for Linux (WSL) running when a desktop
environment or graphical session is in use. Needed when full desktop
environments with display managers are to be used.

**wslg-fix.service**, **/etc/init.d/wslg-fix**  
Ensures proper write access to the X11 socket used by the Windows
Subsystem for Linux GUI (WSLg). Needed by **Xwslg**(1) to function well.

On systemd-based systems, wsl-tools also modifies the user manager
service unit (see **user<span>@</span>.service**(5)) by adding the
following lines:

    [Service]
    ExecStartPost=-/usr/bin/rm -f /run/user/%i/wayland-0 /run/user/%i/wayland-0.lock

# SEE ALSO

**user<span>@</span>.service**(5), **keepwsl**(5), **wslg-fix**(5)
