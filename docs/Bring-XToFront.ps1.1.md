# NAME

Bring-XToFront.ps1 - Brings X server to front

# SYNOPSIS

**Bring-XToFront.ps1**

# DESCRIPTION

**Bring-XToFront.ps1** is a Windows PowerShell script that is used by
**Xwslg**(1) to bring the root window into focus, place it at the front
of the window stack, and hide the taskbar so that the X session fills
the entire screen. It is only used if the system's version of
**Xwayland**(1) does not support the **-fullscreen** or **-geometry**
options and wants to open a fullscreen root window by default.

**Xwslg** will use **daemonify**(1) to run **Bring-XToFront.ps1** as a
daemon when it launches in rootful mode, and **Bring-XToFront.ps1** will
quit automatically once **Xwslg** has fully started up. **Xwslg** never
calls **Bring-XToFront.ps1** when it runs in rootless mode. There is no
need for an ordinary user to invoke **Bring-XToFront.ps1** manually.

# SEE ALSO

**Xwayland**(1), **Xwslg**(1), **daemonify**(1), **powershell**(1)
