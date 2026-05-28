# NAME

daemonify - run command as daemon

# SYNOPSIS

**daemonify** \[**-L** _lockfile_\] \[**-c**\] \[**-h**\] \[**-p**
_pidfile_\] \[*command*\] \[*arguments*...\]

# DESCRIPTION

**daemonify** is a script that runs a command in the background as a
daemon. It does so by launching a subprocess, setting its **umask**(2)
value to 0, then running that command from within the subprocess with
its standard input, output, and error streams redirected to _/dev/null_.
**daemonify** may also save the daemon's process ID (PID) to a file, set
its working directory to _/_ (the root directory), or use a lock file to
ensure that only one instance of the daemon runs at a time.

# OPTIONS

**-L** _lockfile_  
Performs a single-instance check using a lock file. If the file exists,
**daemonify** exits and the daemon does not start. This ensures that
only one instance of the daemon is running at any time.

**-c**  
Changes the daemon's working directory to _/_.

**-h**  
Shows a help message.

**-p** _pidfile_  
Write the daemon's PID to a file. This file can also be used as a lock
file by passing it to **-L**, though many daemons use separate lock and
PID files.

# SEE ALSO

**umask**(2), **daemon**(7)
