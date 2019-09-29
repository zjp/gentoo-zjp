# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# From SoniFrog overlay, https://gpo.zugaina.org/AJAX/Ebuild/38371350/View

EAPI=6
inherit git-r3 autotools vala

DESCRIPTION="An enhanced terminal emulator widget"
HOMEPAGE="https://github.com/thestinger/vte-ng"
LICENSE="LGPL-2.1"
SLOT="0"
EGIT_REPO_URI="https://github.com/thestinger/vte-ng"
EGIT_BRANCH=0.56.2-ng
EGIT_COMMIT=dd74ae7c06e8888af2fc090ac6f8920a9d8227fb

KEYWORDS="~amd64 ~x86"

IUSE="+introspection +crypt glade vala"

RDEPEND="
	>=dev-libs/glib-2.40:2
	>=dev-libs/libpcre2-10.21
	>=x11-libs/gtk+-3.16:3[introspection?]
	>=x11-libs/pango-1.22.0

	sys-libs/ncurses:0=
	sys-libs/zlib

	crypt? ( >=net-libs/gnutls-3.2.7:0= )
	glade? ( >=dev-util/glade-3.9:3.10 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.0:= )
"

DEPEND="${RDEPEND}
	dev-util/gperf
	dev-libs/libxml2
	>=dev-util/gtk-doc-am-1.13
	>=dev-util/intltool-0.35
	sys-devel/gettext

	dev-util/gtk-doc

	!x11-libs/vte

	vala? ( dev-lang/vala )
"

src_prepare() {
	default

	use vala && vala_src_prepare

	eautoreconf
}

src_configure() {
	econf $(use_enable vala)\
		  $(use_enable glade glade-catalogue)\
		  $(use_with crypt gnutls)\
		  $(use_enable introspection)\

}
