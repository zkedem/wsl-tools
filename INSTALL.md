# Installing from source
First, you will need [pkgkit](https://github.com/zkedem/pkgkit):
```
git clone https://github.com/zkedem/pkgkit.git
cd pkgkit
make
sudo make install
```
You will also need `git`, `Xorg`, `Xwayland`, binutils, and the [util-linux](https://github.com/util-linux/util-linux) package. Then, you can install:
```
git clone https://github.com/zkedem/wsl-tools.git
cd wsl-tools
make
sudo make install
```
To reinstall, or to upgrade to a newer version, run:
```
make
sudo make reinstall
```
To uninstall, run:
```
sudo make uninstall
```
You may also use:
```
make clean
```
to clean up any files created by the build process.\
\
By default, the Makefile will install wsl-tools into */usr/local*. But a different installation prefix may be specified as:
```
sudo make install PREFIX=<prefix>
```
where *\<prefix\>* is the prefix directory under which the wsl-tools utilities and documentation will be installed. Note that configuration files and anything else in the *noprefix* directory will be placed under the root directory and not the prefix directory.\
\
The path to the root directory itself can be changed like so:
```
sudo make install ROOTDIR=<rootdir>
```
The Makefile automatically runs scripts before and after installation or uninstallation by default. To skip these scripts, you can use:
```
sudo make install SKIPSCRIPTS=y
```
The `PREFIX`, `ROOTDIR`, and `SKIPSCRIPTS` options may be used together, for example:
```
sudo make install PREFIX=/usr ROOTDIR=/media/sda1 SKIPSCRIPTS=y
```
These options are also accepted by the `reinstall` and `uninstall` targets.

# Building a package
There are no additional prerequisites for building Slackware-type packages. For other package types, you will need to have [Ruby](https://www.ruby-lang.org/en/documentation/installation/) and [fpm](https://fpm.readthedocs.io/en/latest/installation.html) installed. Then, you can build the package:
```
make package
```
By default, the Makefile will automatically build a package for your distribution. You can build a package for a different distribution using:
```
make package TYPE=<type>
```
where *\<type\>* is one of `deb`, `pacman`, `rpm`, `slackware`, or `tar`. Certain package types have additional prerequisites: `pacman` requires `bsdtar`, and `rpm` requires `rpmbuild`.\
\
You may build multiple package types at once like so:
```
make package TYPE=deb,pacman,rpm
```
By default, built packages are saved into a directory called *build*. But this can be changed using:
```
make package BUILDDIR=<builddir>
```
where *\<builddir\>* is the output directory.\
\
The `TYPE` and `BUILDDIR` options may be used together, for example:
```
make package TYPE=pacman BUILDDIR=packages
```
Once built, the package can be installed and uninstalled via your system's package manager.

# Generating Markdown documentation
Documentation for wsl-tools is written as manual pages. These are converted and copied into Markdown format using [pandoc](https://pandoc.org/installing.html) so they can be easily viewed online. Once `pandoc` is installed, you can re-generate the Markdown documentation:
```
make docs
```
By default, the Markdown files are placed in the *docs* directory. You can specify a different directory using:
```
make docs DOCSDIR=<docsdir>
```
where *\<docsdir\>* is the directory that will contain the Markdown documentation.\
\
During the conversion process, `pandoc` will run a Lua filter script that adjusts and formats the output. The default script is *filter.lua*, but a different script may be specified using:
```
make docs LUAFILTER=<luafilter>
```
where *\<luafilter\>* is your custom script.\
\
The `DOCSDIR` and `LUAFILTER` options may be used together, for example:
```
make docs DOCSDIR=/var/www/wsl-tools LUAFILTER=~/script.lua
```
To clean the documentation directory, you can run:
```
make clean_docs [DOCSDIR=<docsdir>]
```

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
		<th>Generating Markdown documentation</th>
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
		<td align="center"></td>
	</tr>
	<tr>
		<th>binutils</th>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center"></td>
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
		<td align="center"></td>
	</tr>
	<tr>
		<th>Ruby</th>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center"></td>
	</tr>
	<tr>
		<th>fpm</th>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center">✔</td>
		<td align="center"></td>
		<td align="center">✔</td>
		<td align="center"></td>
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
		<td align="center"></td>
	</tr>
	<tr>
		<th>pandoc</th>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center"></td>
		<td align="center">✔</td>
	</tr>
</table>
