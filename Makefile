.POSIX:

include pkginfo.mk

ARCHITECTURE = all
BUILDDIR = build
STAGINGDIR = staging
DOCSDIR = docs
MANDIR = share/info,share/man
LUAFILTER = filter.lua
PREFIX = /usr/local

all:
	true

.PHONY: docs

clean:
	for d in '$(BUILDDIR)' '$(STAGINGDIR)'; \
	do \
		case "`realpath "$$d"`" in \
			"`realpath .`"|"`realpath ..`") \
				continue; \
				;; \
		esac; \
		rm -rf "$$d"; \
	done

docs:
	if [ -z `command -v pandoc` ]; \
	then \
		echo 'pandoc is required' >&2; \
		exit 1; \
	fi; \
	if [ ! -d '$(DOCSDIR)' ]; \
	then \
		mkdir -p '$(DOCSDIR)'; \
	fi; \
	echo '$(MANDIR)' | tr , "\n" | while read -r d; \
	do \
		if [ -d "$$d" ]; \
		then \
			find "$$d" -type f | while read -r f; \
			do \
				cat "$$f" | preprocess -e - NAME='$(NAME)' VERSION='$(VERSION)' DATE="`gitchangelog -D '%Y-%m-%d' -r '$(REPO_URL)' -t -v '$(VERSION)'`" | pandoc -f man -t gfm -o "$(DOCSDIR)/`basename "$$f"`.md" --lua-filter '$(LUAFILTER)'; \
			done; \
		fi; \
	done

clean_docs:
	if [ -d '$(DOCSDIR)' ]; \
	then \
		rm '$(DOCSDIR)'/*; \
	fi

install:
	for f in *; \
	do \
		if [ -d "$$f" ]; \
		then \
			case "$$f" in \
				.|..|'$(BUILDDIR)'|'$(DOCSDIR)'|noprefix|'$(STAGINGDIR)'|"`basename "$(ROOTDIR)"`") \
					continue; \
					;; \
			esac; \
			mkdir -p "$(ROOTDIR)$(PREFIX)/$$f"; \
			cp -R "$$f"/* "$(ROOTDIR)$(PREFIX)/$$f"; \
			find "$$f" -type f | grep -E -e "\.in$$" | while read -r g; \
			do \
				preprocess -s "$(ROOTDIR)$(PREFIX)/$$g"; \
				mv "$(ROOTDIR)$(PREFIX)/$$g" "$(ROOTDIR)$(PREFIX)/`dirname "$$g"`/`basename "$$g" | sed -E -e 's/^(.+)\.in$$/\1/'`"; \
			done; \
		fi; \
	done; \
	find noprefix -type d | sed -E -e '/^noprefix$$/d' -e 's/^noprefix//' | while read -r d; \
	do \
		mkdir -p "$(ROOTDIR)$$d"; \
		for f in "noprefix/$$d"/*; \
		do \
			if [ -e "$$f" ] && [ ! -d "$$f" ]; \
			then \
				rm -f "$(ROOTDIR)$$d/`basename "$$f"`"; \
				cp "$$f" "$(ROOTDIR)$$d"; \
			fi; \
		done; \
	done; \
	echo '$(MANDIR)' | tr , "\n" | while read -r d; \
	do \
		if [ -d "$$d" ]; \
		then \
			find "$$d" -type f | while read -r f; \
			do \
				preprocess -s "$(ROOTDIR)$(PREFIX)/$$f" -e - NAME='$(NAME)' VERSION='$(VERSION)' DATE="`gitchangelog -D '%Y-%m-%d' -r '$(REPO_URL)' -t -v '$(VERSION)'`"; \
				if [ -f "$(ROOTDIR)$(PREFIX)/$$f.gz" ]; \
				then \
					rm -f "$(ROOTDIR)$(PREFIX)/$$f.gz"; \
				fi; \
				if [ -n "`command -v gzip`" ]; \
				then \
					gzip -9 "$(ROOTDIR)$(PREFIX)/$$f"; \
				fi; \
			done; \
		fi; \
	done; \
	if [ '$(SKIPSCRIPTS)' != 'y' ]; \
	then \
		`realpath '$(POST_INSTALL)'`; \
	fi

uninstall:
	if [ '$(SKIPSCRIPTS)' != 'y' ]; \
	then \
		`realpath '$(PRE_UNINSTALL)'`; \
	fi; \
	for f in *; \
	do \
		if [ -d "$$f" ]; \
		then \
			case "$$f" in \
				.|..|'$(BUILDDIR)'|'$(DOCSDIR)'|noprefix|'$(STAGINGDIR)'|"`basename "$(ROOTDIR)"`") \
					continue; \
					;; \
			esac; \
			find "$$f" -type f | while read -r i; \
			do \
				if echo "$$i" | grep -E -q -e "\.in$$"; \
				then \
					i="`dirname "$$i"`/`basename "$$i" | sed -E -e 's/^(.+)\.in$$/\1/'`"; \
				else \
					mandir='$(MANDIR)'; \
					while [ -n "$$mandir" ]; \
					do \
						ddir="`echo "$$mandir" | cut -d , -f 1`"; \
						idir="$$i"; \
						until [ "$$idir" = '.' ] || [ "$$idir" = '/' ]; \
						do \
							idir="`dirname "$$idir"`"; \
							if [ "$$idir" = "$$ddir" ]; \
							then \
								i="$$i.gz"; \
								break 2; \
							fi; \
						done; \
						mandir="`echo "$$mandir" | cut -d , -f 2- -s`"; \
					done; \
				fi; \
				rm -f "$(ROOTDIR)$(PREFIX)/$$i"; \
			done; \
		fi; \
	done; \
	find noprefix -type f | sed -E -e 's/^noprefix//' | while read -r f; \
	do \
		rm -f "$(ROOTDIR)$$f"; \
	done; \
	find noprefix -type d | sed -E -e '/^noprefix$$/d' -e 's/^noprefix//' | while read -r d; \
	do \
		d="$(ROOTDIR)$$d"; \
		if [ -z "`find "$$d" | sed -E -e "\:^$$d$$:d"`" ]; \
		then \
			rm -rf "$$d"; \
		fi; \
	done; \
	if [ '$(SKIPSCRIPTS)' != 'y' ]; \
	then \
		`realpath '$(POST_UNINSTALL)'`; \
	fi

reinstall: uninstall install

package:
	TYPE='$(TYPE)'; \
	PREFIX='/usr'; \
	if [ -z "$$TYPE" ]; \
	then \
		if [ -n "`command -v installpkg`" ]; \
		then \
			TYPE=slackware; \
		elif [ -n "`command -v pacman`" ]; \
		then \
			TYPE=pacman; \
		elif [ -n "`command -v dpkg`" ]; \
		then \
			TYPE=deb; \
		elif [ -n "`command -v rpm`" ]; \
		then \
			TYPE=rpm; \
		else \
			TYPE=tar; \
		fi; \
	fi; \
	checkbuilddep() \
	{ \
		if [ -z `command -v -- "$$1"` ]; \
		then \
			echo "$$1 is required to build $${2:+$$2 }packages$${3:+ for architecture $$3}" >&2; \
			exit 1; \
		fi; \
	}; \
	pnformat() \
	{ \
		case "$$2" in \
			'') \
				case '$(ARCHITECTURE)' in \
					all|any) \
						architecture=noarch; \
						;; \
					*) \
						architecture='$(ARCHITECTURE)'; \
						;; \
				esac; \
				;; \
			*) \
				architecture="$$2"; \
				;; \
		esac; \
		echo "$$1" | sed -E -e 's/%%/%/g' -e 's/%n/$(NAME)/g' -e 's/%v/$(VERSION)/g' -e 's/%r/$(RELEASE)/g' -e "s/%a/$$architecture/g"; \
		unset architecture; \
	}; \
	deplist() \
	{ \
		echo "$$1" | tr , "\n" | while read -r d; \
		do \
			echo "--depends $$d"; \
		done; \
	}; \
	configfilelist() \
	{ \
		echo "$$1" | tr , "\n" | while read -r f; \
		do \
			echo "--config-files $$f"; \
		done; \
	}; \
	filelist() \
	{ \
		find "$$1" -type f | while read -r f; \
		do \
			cutoff=`echo "$$1" | wc -m`; \
			echo "$$f=`echo "$$f" | cut -c $$cutoff-`"; \
		done; \
	}; \
	runfpm() \
	{ \
		pname="`pnformat "$$2"`"; \
		if [ -n "`echo '$(MAINTAINER_NAME)' | tr -c -d '.'`" ]; \
		then \
			maintainer='$(MAINTAINER_EMAIL) ($(MAINTAINER_NAME))'; \
		else \
			maintainer='$(MAINTAINER_NAME) <$(MAINTAINER_EMAIL)>'; \
		fi; \
		if [ "$$1" = 'deb' ] || [ "$$1" = 'rpm' ]; \
		then \
			changelogfile="/tmp/`uuidgen`.txt"; \
			gitchangelog -d '$(DEB_DIST)' -n '$(NAME)' -o "$$changelogfile" -r '$(REPO_URL)' -s -t -v '$(VERSION)' "$$1"; \
			exec 3< "$$changelogfile"; \
			changelog="--$$1-changelog /dev/fd/3"; \
		fi; \
		if [ "$$1" != 'tar' ]; \
		then \
			exec 4< '$(POST_INSTALL)'; \
			exec 5< '$(POST_UNINSTALL)'; \
			exec 6< '$(PRE_UNINSTALL)'; \
			scripts='--post-install /dev/fd/4 --post-uninstall /dev/fd/5 --pre-uninstall /dev/fd/6'; \
		fi; \
		fpm -t "$$1" -s dir -p "$$pname" -f -n '$(NAME)' -v '$(VERSION)' --license '$(LICENSE)' -m "$$maintainer" --description '$(DESCRIPTION)' --url '$(URL)' --deb-dist '$(DEB_DIST)' --deb-no-default-config-files -a "`pnformat '%a'`" $$changelog `deplist "$$3"` $$scripts `configfilelist '$(CONFIG_FILES)'` `filelist '$(STAGINGDIR)'`; \
		if [ "$$1" != 'tar' ]; \
		then \
			unset scripts; \
			exec 6<&-; \
			exec 5<&-; \
			exec 4<&-; \
		fi; \
		if [ "$$1" = 'deb' ] || [ "$$1" = 'rpm' ]; \
		then \
			unset changelog; \
			exec 3<&-; \
			rm "$$changelogfile"; \
			unset changelogfile; \
		fi; \
		unset maintainer; \
		unset pname; \
	}; \
	pkgren() \
	{ \
		pattern="`echo "$$1" | sed -E -e 's/%%/%/g' -e 's/%[nrv]/*/g' -e 's/%a/unknown/g'`"; \
		oldname="`find "$$2" -name "$$pattern"`"; \
		case "$$3" in \
			deb) \
				arch="`ar -p "$$oldname" control.tar.gz | tar -x ./control -z -f - -O | grep -E -e '^Architecture: .+$$' | sed -E -e 's/^.+: (.+)$$/\1/'`"; \
				;; \
			pacman) \
				arch="`bsdtar -x -O -f "$$oldname" .PKGINFO | grep -E -e '^arch = .+$$' | sed -E -e 's/^.+ = (.+)$$/\1/'`"; \
				;; \
			*) \
				arch='$(ARCHITECTURE)'; \
				;; \
		esac; \
		newname="$$2/`pnformat "$$1" "$$arch"`"; \
		mv "$$oldname" "$$newname"; \
		echo "Saved package as '$$newname'" >&2; \
		unset newname; \
		unset arch; \
		unset oldname; \
		unset pattern; \
	}; \
	checkbuilddep fpm; \
	mkdir -p '$(STAGINGDIR)'; \
	make install ROOTDIR='$(STAGINGDIR)' PREFIX="$$PREFIX" SKIPSCRIPTS=y; \
	mkdir -p '$(BUILDDIR)'; \
	echo "$$TYPE" | tr , "\n" | while read -r t; \
	do \
		rm -rf '$(STAGINGDIR)/install'; \
		case "$$t" in \
			deb) \
				runfpm "$$t" '$(BUILDDIR)/%n_%v-%r_unknown.deb' '$(DEB_DEPENDS)'; \
				pkgren '%n_%v-%r_%a.deb' '$(BUILDDIR)' "$$t"; \
				;; \
			pacman) \
				checkbuilddep bsdtar "$$t"; \
				runfpm "$$t" '$(BUILDDIR)/%n-%v-%r-unknown.pkg.tar.zst' '$(PACMAN_DEPENDS)'; \
				pkgren '%n-%v-%r-%a.pkg.tar.zst' '$(BUILDDIR)' "$$t"; \
				;; \
			rpm) \
				checkbuilddep rpmbuild "$$t"; \
				runfpm "$$t" '$(BUILDDIR)/%n-%v-%r.%a.rpm' '$(RPM_DEPENDS)'; \
				;; \
			slackware) \
				mkdir -p '$(STAGINGDIR)/install'; \
				cp '$(POST_INSTALL)' '$(STAGINGDIR)/install/doinst.sh'; \
				cp '$(POST_UNINSTALL)' '$(STAGINGDIR)/install/douninst.sh'; \
				find '$(STAGINGDIR)/' | env LC_COLLATE=C sort | sed -E -e 's,^$(STAGINGDIR)/,\./,' -e '2,$$s,^\./,,' | tar --no-recursion --format ustar -C '$(STAGINGDIR)/' -T - -cf - | gzip -9 > "`pnformat '$(BUILDDIR)/%n-%v-%a-%r.tgz'`"; \
				;; \
			tar) \
				runfpm "$$t" '$(BUILDDIR)/%n-%v-%a-%r.tar'; \
				;; \
		esac; \
	done
