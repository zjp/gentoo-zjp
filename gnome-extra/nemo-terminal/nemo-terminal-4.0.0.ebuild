# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
PYTHON_COMPAT=( python3_{6,7,8} )

inherit python-single-r1 gnome2-utils

DESCRIPTION="Nemo extension to enable an embedded terminal"
HOMEPAGE="https://github.com/linuxmint/nemo-extensions"
SRC_URI="https://github.com/linuxmint/nemo-extensions/archive/${PV}.tar.gz -> nemo-extensions-${PV}.tar.gz"
S="${WORKDIR}/nemo-extensions-${PV}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND=">=gnome-extra/nemo-python-${PV}
	x11-libs/vte:2.91
	dev-python/pyxdg[${PYTHON_USEDEP}]"

src_install() {
	default
	python_fix_shebang src/
	exeinto usr/share/nemo-python/extensions/
	doexe src/nemo_terminal.py

	insinto usr/share/glib-2.0/schemas
	doins src/org.nemo.extensions.nemo-terminal.gschema.xml

	insinto usr/share/nemo-terminal
	doins pixmap/logo_120x120.png
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
