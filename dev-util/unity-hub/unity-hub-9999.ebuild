# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Copied from szorfein/ninjatools
# https://github.com/szorfein/ninjatools/blob/master/media-fonts/material-icons/material-icons-3.0.1.ebuild
EAPI=7

inherit desktop

DESCRIPTION="Hub for the Unity Engine"
HOMEPAGE="https://unity.com/"
SRC_URI="https://public-cdn.cloud.unity3d.com/hub/prod/UnityHub.AppImage"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
}

src_compile() {
	true
}

src_install() {
	newbin ${WORKDIR}/UnityHub.AppImage unity-hub
	make_desktop_entry /usr/bin/unity-hub "Unity Hub" Graphics
}
