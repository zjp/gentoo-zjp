# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{6,7,8} )

inherit meson python-r1

DESCRIPTION="Python binding for Nemo components"
HOMEPAGE="https://github.com/linuxmint/nemo-extensions"
SRC_URI="https://github.com/linuxmint/nemo-extensions/archive/${PV}.tar.gz -> nemo-extensions-${PV}.tar.gz"
S="${WORKDIR}/nemo-extensions-${PV}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="${PYTHON_DEPS}"
DEPEND="${RDEPEND}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=gnome-extra/nemo-${PV}[introspection]
	>=dev-util/gtk-doc-am-1.9
	virtual/pkgconfig
"
src_prepare() {
	grep -rl "python3" "${WORKDIR}"/nemo-extensions-"${PV}"/nemo-python/* | xargs sed -i 's/python3/python/g'
}
