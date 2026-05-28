# NAME

keepwsl.service - keep WSL alive

# SYNOPSIS

**keepwsl.service**

# DESCRIPTION

The Windows Subsystem for Linux (WSL) has a feature where it
automatically shuts down if there are no console windows in the
foreground and there are no background processes that are not managed by
systemd. While this can often help in conserving energy and system
resources, it gets in the way of running graphical applications and
desktop environments on WSL. **keepwsl.service** circumvents this
feature by using the **wsl**(1) wrapper script to create a
low-intensity, perpetual background process whenever the systemd
graphical target is active.

If you have installed wsl-tools from your package manager,
**keepwsl.service** should be enabled by default. If this is not the
case, and you wish to use desktop environments on WSL, run
'**systemctl** enable keepwsl.service'.

# SEE ALSO

**wsl**(1), **wsl-tools-services**(5)
