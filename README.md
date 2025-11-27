# wsl-tools
A set of useful tools for WSL.

# Backstory
A while ago, I decided to reinstall WSL, and I also wanted to use desktop environments (GNOME and XFCE) with it. I found it incredibly frustrating and tedious reconfiguring and setting up everything from scratch. Following a [guide](https://gist.github.com/tdcosta100/e28636c216515ca88d1f2e7a2e188912) by tdcosta100, I began writing shell scripts to automate some of the tasks. Then I figured I could have everything set up and ready to go in one easy step if I bundled those scripts into a package, and that is exactly what I have done here.

# Purpose
The purpose of wsl-tools is to provide enhanced integration and functionality to WSL, especially when using desktop environments and graphical applications.

# Installing from source
First, you will need [pkgkit](https://github.com/zkedem/pkgkit):
```
git clone https://github.com/zkedem/pkgkit.git
cd pkgkit
make
sudo make install
```
You will also need `git`, `Xorg`, `Xwayland`, and the [util-linux](https://github.com/util-linux/util-linux) package. Then, you can install:
```
git clone https://github.com/zkedem/wsl-tools.git
cd wsl-tools
make
sudo make install
```
Optional, but recommended post-install:
```
sudo systemctl enable wslg-fix.service
sudo systemctl enable keepwsl.service
sudo systemctl daemon-reload
sudo Xwslg -divert Xorg
```
To reinstall, or to upgrade to a newer version, run:
```
make
sudo make reinstall
```
To uninstall, run:
```
sudo Xwslg -restore Xorg
sudo systemctl disable keepwsl.service
sudo systemctl disable wslg-fix.service
sudo make uninstall
sudo systemctl daemon-reload
```

# Building a package
You will need to have [Ruby](https://www.ruby-lang.org/en/documentation/installation/) and [fpm](https://fpm.readthedocs.io/en/latest/installation.html) installed. Then, you can build the package:
```
make package
```
By default, the Makefile will automatically build a package for your distribution. You can build a package for a different distribution using:
```
make package TYPE=<type>
```
where "type" is one of `deb`, `pacman`, `rpm`, `slackware`, or `tar`. Note that Slackware support is incomplete and is actively being worked on. Certain package types have additional prerequisites: `pacman` requires `bsdtar`, and `rpm` requires `rpmbuild`.\
\
You may build multiple package types at once like so:
```
make package TYPE=deb,pacman,rpm
```
By default, built packages are saved into a directory called "build". But this can be changed using:
```
make package BUILDDIR=<builddir>
```
where "builddir" is the output directory.\
\
The `TYPE` and `BUILDDIR` options may be used together:
```
make package TYPE=pacman BUILDDIR=packages
```
Once built, the package can be installed and uninstalled via your system's package manager.

# Dependencies
Below is a table of dependencies for installing and packaging wsl-tools:
<table>
	<tr>
		<th></th>
		<th>Installing a prebuilt package</th>
		<th>Installing from source</th>
		<th>Building a <code>deb</code> package</th>
		<th>Building a <code>pacman</code> package</th>
		<th>Building an <code>rpm</code> package</th>
		<th>Building a <code>slackware</code> package</th>
		<th>Building a <code>tar</code> package</th>
	</tr>
	<tr>
		<th>pkgkit</th>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
	</tr>
	<tr>
		<th>git</th>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
	</tr>
	<tr>
		<th>Xorg</th>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
	</tr>
	<tr>
		<th>Xwayland</th>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
	</tr>
	<tr>
		<th>util-linux</th>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
	</tr>
	<tr>
		<th>Ruby</th>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
	</tr>
	<tr>
		<th>fpm</th>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
	</tr>
	<tr>
		<th>bsdtar</th>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
	</tr>
	<tr>
		<th>rpmbuild</th>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center"></td>
		<td align="center"></td>
	</tr>
</table>

# What's included

## Xwslg
A wrapper script for `Xwayland` that replaces `Xorg` under WSL. It can be used to display whole X sessions and desktop environments under WSLg.

### Usage
```
Xwslg [option ...]
```

### Options
`Xwslg` accepts the same options as [Xwayland](https://www.mankier.com/1/Xwayland) and [other X servers](https://www.x.org/releases/current/doc/man/man1/Xserver.1.xhtml). But some options are modified, and `Xwslg` also adds its own options; these are described below:

#### :<span>displaynumber</span>
By default, `Xwslg` runs as display number 0\. But an alternative display number can instead be specified, such as `:1`, `:2`, `:3`, etc. If neither display number 0 nor a user-specified display number are available, `Xwslg` will instead select the lowest available display number.

#### -geometry <span>WxH|auto</span>
Sets the geometry of the `Xwayland` window to `WxH` when running in rootful mode. If `auto` is instead specified, the geometry will automatically be set to match that of the physical monitor. `auto` is useful if you want to run `Xwslg` fullscreen and have the X session use the same resolution as Windows.

#### -divert <span>cmd</span>
Diverts the command `cmd` to `Xwslg`. This means that, when you attempt to run `cmd`, `Xwslg` wil be called instead. `cmd` should accept the same command line options as a typical X server.\
\
In most cases, if you install wsl-tools from a prebuilt package, `Xorg` will be diverted to `Xwslg` by default.\
\
`cmd` will still be available as `cmd.diverted`.

#### -restore <span>cmd</span>
Restores a command that has been diverted to `Xwslg`, undoing the diversion.

### Configuration
`Xwslg` has a configuration file at \/etc/X11/xwslg.conf, which has some settings enabled by default. The format is similar to that of xorg.conf. For more information, run:
```
man 5 xwslg.conf
```
or open the default xwslg.conf file in a text editor; the comments explain the purpose of each section and every entry.

### Environment variables

#### WAYLAND_DISPLAY
The name of the Wayland display used by Xwslg.

#### XWAYLAND_NO_GLAMOR
Can be set to disable glamor and DRI3 support for testing purposes.

#### XWSLGCONFIG
Path to a configuration file. This is interpreted as an absolute path for the root user, or as a relative path for all other users.

## daemonify
A script that runs any command in the background as a daemon. It works by running the command from a subprocess with its `umask` value set to 0 and redirecting its standard I/O streams to \/dev/null.

### Usage
```
daemonify [-L lockfile] [-c] [-h] [-p pidfile] [command] [arguments...]
```

### Options

#### -L <span>lockfile</span>
Single-instance checking using a lock file. If the file exists, the daemon will not start. This ensures that only one instance of the daemon runs at a time.

#### -c
Change working directory to \/ (the root directory) when starting daemon.

#### -h
Show the help message.

#### -p <span>pidfile</span>
Saves the daemon's process ID to a file. The same file can also be used as a lock file with the `-L` option, but many daemons use separate lock and PID files.

## wsl
Launches a new instance of WSL from within WSL itself, by calling Windows' `wsl.exe`.

### Usage
```
wsl [Argument] [Options...] [CommandLine]
```

### Options
`wsl` takes the same command line options as `wsl.exe` For more information about WSL commands, see [Basic commands for WSL](https://learn.microsoft.com/en-us/windows/wsl/basic-commands), or run:
```
wsl --help
```
or read the manual page:
```
man 1 wsl
```
Unlike `wsl.exe`, most options apart from `--help`, `--list`, `--status`, and `--version` are only available to the root user. This is to prevent regular users from running privileged commands without password authentication. `wsl` also adds an extra option, which is described below:

#### --this-distribution
Starts a new session of the current distribution. For instance, if you are using Debian, this is the same as passing `-d Debian` to `wsl`.

## Service units
- **keepwsl.service**: Keeps WSL running when a graphical session is active; not enabled by default.
- **wslg-fix.service**: Ensures read/write access to X11 sockets for graphical applications; enabled by default when wsl-tools is installed from a prebuilt package.
- **user<span>@</span>.service**: Modified to ensure proper cleanup of Wayland lock files.

For more information, run:
```
man 8 wsl-tools-services
```

# License
wsl-tools is licensed under the GNU General Public License v3.0.
