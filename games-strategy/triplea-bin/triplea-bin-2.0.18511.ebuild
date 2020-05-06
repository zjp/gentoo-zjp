# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION=""
HOMEPAGE="https://triplea-game.org/"
SRC_URI="https://github.com/triplea-game/triplea/releases/download/${PV}/triplea-game-headed-${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jre-1.8
	dev-util/gtk-update-icon-cache"
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r ${WORKDIR}/*
	doins ${WORKDIR}}/.triplea-root
	echo -e "#! /bin/bash \n cd /usr/share/${PN}/bin \n java -jar triplea-game-headed-${PV}.jar" > ${WORKDIR}/triplea
	exeinto "/usr/bin"
	doexe ${WORKDIR}/triplea
}
