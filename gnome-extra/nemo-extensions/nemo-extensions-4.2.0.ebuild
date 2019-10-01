# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#template copied from https://gpo.zugaina.org/AJAX/Ebuild/2927437
EAPI=5

inherit autotools

DESCRIPTION="extensions for cinnamon's file-manager nemo"
HOMEPAGE="https://github.com/linuxmint/nemo-extensions"
SRC_URI="https://github.com/linuxmint/nemo-extensions/archive/${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

# Possible extensions that have to be tested
# -compare -dropbox -foldercolor -gtkhash -imageconverter -mediacolumns -pastebin -preview -python -rabbitvcs -repairer -seahorse -share -terminal

# Tested extensions
#IUSE="fileroller compare dropbox foldercolor gtkhash imageconverter mediacolumns pastebin preview -python rabbitvcs repairer seahorse share terminal"
IUSE="fileroller share"
MODULES=${IUSE//-/}

DEPEND="( >=gnome-extra/nemo-4.0.0[introspection] )
		fileroller? ( app-arch/file-roller )
                share? ( net-fs/samba )"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
        cd "${S}"
	mv ${PN}-${PV} ${P}
}

src_prepare () {
	for module in ${MODULES}
		do
		if use ${module}
			then
			elog "Preparing ${module}"
			pushd nemo-${module}
			eautoreconf
			popd
		fi
	done
}

src_configure () {
	for module in ${MODULES}
		do
		if use ${module}
			then
			elog "Configuring ${module}"
			pushd nemo-${module}
			econf
			popd
		fi
	done
}

src_compile () {
	for module in ${MODULES}
		do
		if use ${module}
			then
			elog "Compiling ${module}"
			pushd nemo-${module}
			emake
			popd
		fi
	done
}

src_install () {
	for module in ${MODULES}
		do
		if use ${module}
			then
			elog "Installing ${module}"
			pushd nemo-${module}
			emake DESTDIR="${D}" install
			elog "Removing .a and .la files"
			find ${D} -name "*.a" -exec rm {} + -o -name "*.la" -exec rm {} + || die
			dodoc README
			popd
		fi
	done
}
