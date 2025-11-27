.POSIX:

include pkginfo.mk

ARCHITECTURE = all
BUILDDIR = build
STAGINGDIR = staging
DOCDIR = share/info,share/man
PREFIX = /usr/local

all:
	true

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

install:
	for f in *; \
	do \
		if [ -d "$$f" ]; \
		then \
			case "$$f" in \
				.|..|'$(BUILDDIR)'|noprefix|'$(STAGINGDIR)'|"`basename "$(ROOTDIR)"`") \
					continue; \
					;; \
			esac; \
			mkdir -p "$(ROOTDIR)$(PREFIX)/$$f"; \
			cp -R "$$f"/* "$(ROOTDIR)$(PREFIX)/$$f"; \
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
	echo '$(DOCDIR)' | tr , "\n" | while read -r d; \
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
	done

uninstall:
	for f in *; \
	do \
		if [ -d "$$f" ]; \
		then \
			case "$$f" in \
				.|..|'$(BUILDDIR)'|noprefix|'$(STAGINGDIR)'|"`basename "$(ROOTDIR)"`") \
					continue; \
					;; \
			esac; \
			find "$$f" -type f | while read -r i; \
			do \
				docdir='$(DOCDIR)'; \
				while [ -n "$$docdir" ]; \
				do \
					ddir="`echo "$$docdir" | cut -d , -f 1`"; \
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
					docdir="`echo "$$docdir" | cut -d , -f 2- -s`"; \
				done; \
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
	done

reinstall: uninstall install

package:
	TYPE='$(TYPE)'; \
	if [ -z "$$TYPE" ]; \
	then \
		if [ -n "`command -v dpkg`" ]; \
		then \
			TYPE=deb; \
		elif [ -n "`command -v pacman`" ]; \
		then \
			TYPE=pacman; \
		elif [ -n "`command -v rpm`" ]; \
		then \
			TYPE=rpm; \
		elif [ -n "`command -v installpkg`" ]; \
		then \
			TYPE=slackware; \
		else \
			TYPE=tar; \
		fi; \
	fi; \
	checkbuilddep() \
	{ \
		if [ -z `command -v -- "$$1"` ]; \
		then \
			echo "$$1 is required to build $${2:+$$2 }packages$${3:+ for architecture $$3}" > /dev/stderr; \
			exit 1; \
		fi; \
	}; \
	pnformat() \
	{ \
		case '$(ARCHITECTURE)' in \
			all|any|noarch) \
				case "$$2" in \
					deb) \
						architecture=all; \
						;; \
					pacman) \
						architecture=any; \
						;; \
					*) \
						architecture=noarch; \
						;; \
				esac; \
				;; \
			*) \
				case "$$2" in \
					deb) \
						checkbuilddep dpkg "$$2" '$(ARCHITECTURE)'; \
						architecture="`dpkgarch '$(ARCHITECTURE)'`"; \
						;; \
					*) \
						architecture='$(ARCHITECTURE)'; \
						;; \
				esac; \
				;; \
		esac; \
		echo "$$1" | sed -E -e 's/%%/%/g' -e 's/%n/$(NAME)/g' -e 's/%v/$(VERSION)/g' -e 's/%r/$(RELEASE)/g' -e "s/%a/$$architecture/g"; \
		unset architecture; \
	}; \
	random() \
	{ \
		dd if=/dev/random bs=1 count=2 2>/dev/null | od -t u2 | grep -E -v -e '^0+2' | sed -E -e 's/^([0-7]+) +([0-9]+)$$/\2/'; \
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
		pname="`pnformat "$$2" "$$1"`"; \
		if [ -n "`echo '$(MAINTAINER_NAME)' | tr -c -d '.'`" ]; \
		then \
			maintainer='$(MAINTAINER_EMAIL) ($(MAINTAINER_NAME))'; \
		else \
			maintainer='$(MAINTAINER_NAME) <$(MAINTAINER_EMAIL)>'; \
		fi; \
		if [ "$$1" = 'deb' ] || [ "$$1" = 'rpm' ]; \
		then \
			changelogfile="/tmp/`random`.txt"; \
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
		fpm -t "$$1" -s dir -p "$$pname" -f -n '$(NAME)' -v '$(VERSION)' --license '$(LICENSE)' -m "$$maintainer" --description '$(DESCRIPTION)' --url '$(URL)' --deb-dist '$(DEB_DIST)' --deb-no-default-config-files -a "`pnformat '%a' "$$1"`" $$changelog `deplist "$$3"` $$scripts `configfilelist '$(CONFIG_FILES)'` `filelist '$(STAGINGDIR)'`; \
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
	checkbuilddep fpm; \
	mkdir -p '$(STAGINGDIR)'; \
	make install ROOTDIR='$(STAGINGDIR)' PREFIX=/usr; \
	mkdir -p '$(BUILDDIR)'; \
	echo "$$TYPE" | tr , "\n" | while read -r t; \
	do \
		rm -rf '$(STAGINGDIR)/install'; \
		case "$$t" in \
			deb) \
				runfpm "$$t" '$(BUILDDIR)/%n_%v-%r_%a.deb' '$(DEB_DEPENDS)'; \
				;; \
			pacman) \
				checkbuilddep bsdtar "$$t"; \
				runfpm "$$t" '$(BUILDDIR)/%n-%v-%r-%a.pkg.tar.zst' '$(PACMAN_DEPENDS)'; \
				;; \
			rpm) \
				checkbuilddep rpmbuild "$$t"; \
				runfpm "$$t" '$(BUILDDIR)/%n-%v-%r.%a.rpm' '$(RPM_DEPENDS)'; \
				;; \
			slackware) \
				mkdir -p '$(STAGINGDIR)/install'; \
				preprocess -s doinst.sh.in -d '$(STAGINGDIR)/install/doinst.sh' DEPENDS='$(SLACKWARE_DEPENDS)'; \
				runfpm 'tar' '$(BUILDDIR)/%n-%v-%a-%r.tgz'; \
				;; \
			tar) \
				runfpm "$$t" '$(BUILDDIR)/%n-%v-%a-%r.tar'; \
				;; \
		esac; \
	done
