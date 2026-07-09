# NAME

mkinitctl - create control channel for init

# SYNOPSIS

**/etc/init.d/mkinitctl** { **start** \| **stop** \| **restart** \|
**force-reload** \| **status** }

# DESCRIPTION

On systems that do not use systemd, **init** makes use of a named pipe
at _/dev/initctl_ or _/run/initctl_ to receive control messages from
**poweroff**(8), **reboot**(8), **shutdown**(8), **telinit**(8), and
similar utilities. Under the Windows Subsystem for Linux (WSL), this
named pipe may not be created automatically, leaving these utilities
unusable and making **init** unable to change runlevels.

When enabled, **mkinitctl** runs automatically at startup, recreating
the named pipe and signaling **init** to start reading from it. The
named pipe is created as _/run/initctl_ with a symbolic link at
_/dev/initctl_, so applications can use either path. This allows the
system to change runlevels and shut down. **mkinitctl** may also be
invoked manually as '**/etc/init.d/mkinitctl start**'.

**mkinitctl** should be enabled by default on all non-systemd-based
systems. It is not used on systems that do have systemd.

# SEE ALSO

**poweroff**(8), **reboot**(8), **shutdown**(8), **telinit**(8)
