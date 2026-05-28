# wsl-tools
A set of useful tools for WSL.

# Backstory
A while ago, I decided to reinstall WSL, and I also wanted to use desktop environments (GNOME and XFCE) with it. I found it incredibly frustrating and tedious reconfiguring and setting up everything from scratch. Following a [guide](https://gist.github.com/tdcosta100/e28636c216515ca88d1f2e7a2e188912) by tdcosta100, I began writing shell scripts to automate some of the tasks. Then I figured I could have everything set up and ready to go in one easy step if I bundled those scripts into a package, and that is exactly what I have done here.

# Purpose
The purpose of wsl-tools is to provide enhanced integration and functionality to WSL, especially when using desktop environments and graphical applications.

# Installing and packaging
Please read [INSTALL.md](INSTALL.md) for installation and packaging instructions.

# What's included

## Xwslg
A launcher for `Xwayland` that replaces `Xorg` under WSL. It can be used to display whole X sessions and desktop environments under WSLg.

### Usage
```
Xwslg [option ...]
```
`Xwslg` accepts the same options as `Xwayland` and [other X servers](https://www.x.org/releases/current/doc/man/man1/Xserver.1.xhtml). For full usage information, including information about `Xwslg`-specific options, read the [manual page](docs/Xwslg.1.md):
```
man 1 Xwslg
```
`Xwslg` also uses configuration files in a format similar to that of `Xorg`. These are described in the [xwslg.conf manual page](docs/xwslg.conf.5.md):
```
man 5 xwslg.conf
```
You can also open the default xwslg.conf file in a text editor; the comments explain the purpose of each section and every entry.

## daemonify
A script that runs any command in the background as a daemon. It works by running the command from a subprocess with its `umask` value set to 0 and redirecting its standard I/O streams to */dev/null*.

### Usage
```
daemonify [-L lockfile] [-c] [-h] [-p pidfile] [command] [arguments...]
```
For full usage information, read the [manual page](docs/daemonify.1.md):
```
man 1 daemonify
```

## wsl
Launches a new instance of WSL from within WSL itself, by calling Windows' `wsl.exe`.

### Usage
```
wsl [Argument] [Options...] [CommandLine]
```

### Options
`wsl` takes the same command line options as `wsl.exe`, which are described in [Basic commands for WSL](https://learn.microsoft.com/en-us/windows/wsl/basic-commands), as well as additional options not supported by `wsl.exe`. For complete information about command line options, run:
```
wsl --help
```
or read the [manual page](docs/wsl.1.md):
```
man 1 wsl
```
Unlike `wsl.exe`, most options apart from `--help`, `--list`, `--status`, and `--version` are only available to the root user. This is to prevent regular users from running privileged commands without password authentication.

## powershell
Allows Windows PowerShell and PowerShell scripts to be used from within WSL.

### Usage
```
powershell [-PSConsoleFile <file> | -Version <version>]
   [-NoLogo] [-NoExit] [-Sta] [-Mta] [-NoProfile] [-NonInteractive]
   [-InputFormat {Text | XML}] [-OutputFormat {Text | XML}]
   [-WindowStyle <style>] [-EncodedCommand <Base64EncodedCommand>]
   [-ConfigurationName <string>]
   [-File <filePath> <args>] [-ExecutionPolicy <ExecutionPolicy>]
   [-WorkingDirectory <directoryPath>]
   [-Command { - | <script-block> [-args <arg-array>]
				 | <string> [<CommandParameters>] } ]
   [-WslPSConsoleFile <file>]
   [-WslFile <filePath> <args>]
   [-WslWorkingDirectory <directoryPath>]

powershell -Help | -? | /?
```
For full usage information, read the [manual page](docs/powershell.1.md):
```
man 1 powershell
```

### Script support
PowerShell scripts are supported. The scripts should have a *.ps1* file extension and begin with the following line:
```
#!/bin/env -S powershell -ExecutionPolicy Bypass -WslFile
```

## Bring-XToFront.ps1
This PowerShell script is used by `Xwslg` to initialize itself.

## Return-ToWindows.ps1
This PowerShell script minimizes the current active X session and restores focus to the Windows desktop.

### Usage
```
Return-ToWindows.ps1
```
For more information, read the [manual page](docs/Return-ToWindows.ps1.1.md):
```
man 1 Return-ToWindows.ps1
```

### Shortcut
A shortcut (desktop entry) for `Return-ToWindows.ps1` named "Return To Windows" is placed under the *System* category for your convenience.

## Service units
- **keepwsl.service**: Keeps WSL running when a graphical session is active; enabled by default.
- **wslg-fix.service**: Ensures read/write access to X11 sockets for graphical applications; enabled by default.
- **user<span>@</span>.service**: Modified to ensure proper cleanup of Wayland lock files.

For more information, read the [manual page](docs/wsl-tools-services.5.md):
```
man 5 wsl-tools-services
```

# License
wsl-tools is licensed under the GNU General Public License v3.0.

Some [icons](share/icons) are borrowed from the [RRZE Icon Set](https://github.com/RRZE-PP/rrze-icon-set), which is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported [license](https://creativecommons.org/licenses/by-sa/3.0/).
