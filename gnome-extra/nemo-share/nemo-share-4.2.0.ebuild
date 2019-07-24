# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Copied from Roko__'s overlay
# https://gpo.zugaina.org/AJAX/Ebuild/38250479/View

EAPI=5

inherit autotools eutils

DESCRIPTION="Nemo extension to share folder using Samba"
HOMEPAGE="https://github.com/linuxmint/nemo-extensions"
SRC_URI="https://codeload.github.com/linuxmint/nemo-extensions/tar.gz/4.2.0"
S="${WORKDIR}/nemo-extensions-4.2.0/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="net-fs/samba
	>=gnome-extra/nemo-4.2.0[introspection]"

src_prepare() {
	if [[ ! -e configure ]] ; then
		./autogen.sh || die
	fi
}

pkg_postinst() {
    elog "a sample smb.conf to use this extension:"
    elog ""
    elog "[global]"
    elog "workgroup = HOME"
    elog "security = share"
    elog "usershare path = /var/lib/samba/usershares"
    elog "usershare max shares = 100"
    elog "usershare allow guests = yes"
    elog "usershare owner only = yes"
    elog "wins support = no"
}

