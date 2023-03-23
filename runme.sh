#!/bin/sh
GIT_SHINY_BUILDROOT_REPO="https://github.com/shinymetal6/RetroPlatform"
GIT_SHINY_PATCH="buildroot-2023.05_MiSTer.patch"
GIT_BUILDROOT_NAME="buildroot"
GIT_BUILDROOT_REPO="https://github.com/buildroot/${GIT_BUILDROOT_NAME}"
GIT_BUILDROOT_VERSION="2023.05"
BUILDROOT_MISTER_DEFCONFIG="MiSTer_defconfig"
GCC_VERSION="10.2-2020.11"
GCC_PACKAGE_NAME="gcc-arm-${GCC_VERSION}-x86_64-arm-none-linux-gnueabihf"
GCC_TARBALL="${GCC_PACKAGE_NAME}.tar.xz"
GCC_DOWNLOAD_LINK="https://developer.arm.com/-/media/Files/downloads/gnu-a/${GCC_VERSION}/binrel/${GCC_TARBALL}"

[ ! -d BuildrootDownloads ] && mkdir BuildrootDownloads
if [ ! -f ${GCC_TARBALL} ]; then
	wget --no-check-certificate ${GCC_DOWNLOAD_LINK}
	if [ "$?" == "0" ]; then
		tar xvf ${GCC_TARBALL}
	else
		echo "wget error"
		exit 1
	fi
fi

if [ ! -d buildroot-2023.05_MiSTer ]; then
	git clone ${GIT_BUILDROOT_REPO}
	git clone ${GIT_SHINY_BUILDROOT_REPO}
	cd ${GIT_BUILDROOT_NAME}
	git checkout v2023.05
	git apply ../${GIT_SHINY_PATCH}
	make ${BUILDROOT_MISTER_DEFCONFIG}
	cd ..
fi

