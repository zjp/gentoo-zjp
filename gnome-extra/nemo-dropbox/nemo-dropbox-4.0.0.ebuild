# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
GNOME2_EAUTORECONF="yes"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python2_7 )

inherit gnome2

DESCRIPTION="Dropbox integration for Nemo"
HOMEPAGE="https://github.com/linuxmint/nemo-extensions"
SRC_URI="https://github.com/linuxmint/nemo-extensions/archive/${PV}.tar.gz  -> nemo-extensions-${PV}.tar.gz"
S="${WORKDIR}/nemo-extensions-${PV}/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=gnome-extra/nemo-4.0.0[introspection] dev-python/pygtk net-misc/dropbox sys-process/procps dev-python/pygpgme sys-auth/polkit"
RDEPEND="${DEPEND}"

src_prepare() {
	# Use system dropbox.
	sed -e "s|/var/lib/dropbox|/opt/dropbox|" -e 's|\(DROPBOXD_PATH = \).*|\1"/opt/dropbox/dropboxd"|' -i dropbox.in || die
	grep -rl python "${WORKDIR}"/* | xargs sed -i 's/python/python2/g'
	gnome2_src_prepare
}
