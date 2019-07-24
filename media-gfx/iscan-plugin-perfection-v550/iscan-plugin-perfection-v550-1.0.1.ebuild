# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit versionator multilib

MY_PV="$(get_version_component_range 1-3)"
MY_PVR="$(replace_version_separator 3 -)"
PLUGIN_VER="1.0.0-2"

DESCRIPTION="Epson Perfection V550 scanner plugin for SANE 'epkowa' backend"
HOMEPAGE="http://download.ebz.epson.net/dsc/search/01/search/?OSC=LX"
SRC_URI="amd64? ( 
https://download2.ebz.epson.net/iscan/plugin/perfection-v550/rpm/x64/iscan-perfection-v550-bundle-1.0.1.x64.rpm.tar.gz )
        x86? ( 
https://download2.ebz.epson.net/iscan/plugin/perfection-v550/rpm/x86/iscan-perfection-v550-bundle-1.0.1.x86.rpm.tar.gz )"
LICENSE="AVASYS"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

IUSE=""

DEPEND=">=media-gfx/iscan-2.21.0 app-arch/rpm2targz"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

QA_PREBUILT="/opt/iscan/lib/libiscan-plugin-perfection-v550.so*"

src_configure() { :; }
src_compile() { :; }

src_install() {
	# install scanner firmware
	rpm2targz "${WORKDIR}"/iscan-perfection-v550-bundle-"${PVR}".{x64,x86}.rpm/plugins/iscan-plugin-perfection-v550-"${PLUGIN_VER}".{x86_64,i386}.rpm
	tar -xzvf "${WORKDIR}"/iscan-plugin-perfection-v550-*.tar.gz
	rm "${WORKDIR}"/iscan-plugin-perfection-v550-*.tar.gz
	rm -rf "${WORKDIR}"/iscan*.rpm
	insinto /usr/share/iscan
	doins "${WORKDIR}"/usr/share/iscan/*

	dodoc usr/share/doc/*/*

	# install scanner plugins
	exeinto /opt/iscan/lib
	doexe "${WORKDIR}/usr/$(get_libdir)/iscan/"*
}

pkg_setup() {
	basecmds=( "iscan-registry --COMMAND interpreter usb 0x04b8 0x013b /opt/iscan/lib/libiscan-plugin-perfection-v550 /usr/share/iscan/esfweb.bin" )
}

pkg_postinst() {
	elog
	elog "Firmware file esfweb.bin for Epson Perfection V550"
	elog "has been installed in /usr/share/iscan."
	elog

	# Only register scanner on new installs
	[[ -n ${REPLACING_VERSIONS} ]] && return

	 Needed for scanner to work properly.
	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/add}
		done
		elog "New firmware has been registered automatically."
		elog
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/add}"
		done
	fi
}

pkg_prerm() {
	# Only unregister on on uninstall
	[[ -n ${REPLACED_BY_VERSION} ]] && return

	if [[ ${ROOT} == "/" ]]; then
		for basecmd in "${basecmds[@]}"; do
			eval ${basecmd/COMMAND/remove}
		done
	else
		ewarn "Unable to register the plugin and firmware when installing outside of /."
		ewarn "execute the following command yourself:"
		for basecmd in "${basecmds[@]}"; do
			ewarn "${basecmd/COMMAND/remove}"
		done
	fi
}
