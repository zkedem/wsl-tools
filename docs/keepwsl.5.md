# NAME

keepwsl - keep WSL alive

# SYNOPSIS

**keepwsl.service**  
**/etc/init.d/keepwsl** { **start** \| **stop** \| **restart** \|
**force-reload** \| **status** }

# DESCRIPTION

The Windows Subsystem for Linux (WSL) has a feature where it
automatically shuts down if there are no console windows in the
foreground and there are no background processes that are not managed by
systemd. While this can often help in conserving energy and system
resources, it gets in the way of running graphical applications and
desktop environments on WSL. **keepwsl** circumvents this feature by
using the **wsl**(1) wrapper script to create a low-intensity, perpetual
background process whenever a graphical login session is active.

**keepwsl** should be enabled by default on all systems. If you are
using a systemd-based system and **keepwsl** is not enabled, and you
wish to use desktop environments on WSL, run '**systemctl enable
keepwsl**'.

# SEE ALSO

**wsl**(1), **wsl-tools-services**(5)
