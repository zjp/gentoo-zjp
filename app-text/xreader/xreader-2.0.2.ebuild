# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
GNOME2_EAUTORECONF="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="X-Apps document reader"
HOMEPAGE="https://github.com/linuxmint/xreader"
SRC_URI="https://github.com/linuxmint/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="dbus comics djvu dvi epub +introspection gnome-keyring +postscript t1lib tiff xps"

REQUIRED_USE="t1lib? ( dvi )"

PATCHES=( "${FILESDIR}"/${PN}-libview.patch )

RDEPEND="
	>=dev-libs/glib-2.36:2[dbus]
	>=dev-libs/libxml2-2.5:2
	sys-libs/zlib:=
	x11-libs/gdk-pixbuf:2
	>=x11-libs/libSM-1:0
	x11-libs/libX11:0
	>=x11-libs/cairo-1.14:=
	>=x11-libs/gtk+-3.14:3[introspection?]
	>=x11-libs/xapps-1.1.0
	>=app-text/poppler-0.22:=[cairo]
	djvu? ( >=app-text/djvu-3.5.17:= )
	dvi? (
		virtual/tex-base
		dev-libs/kpathsea:=
		t1lib? ( >=media-libs/t1lib-5:= )
	)
	epub? ( >=net-libs/webkit-gtk-2.4.3:4 )
	gnome-keyring? ( >=app-crypt/libsecret-0.5 )
	introspection? ( >=dev-libs/gobject-introspection-0.6:= )
	postscript? ( >=app-text/libspectre-0.2:0 )
	tiff? ( >=media-libs/tiff-3.6:0= )
	xps? ( >=app-text/libgxps-0.2.1:= )
"

DEPEND="${RDEPEND}
	gnome-base/gnome-common
	app-text/docbook-xml-dtd:4.1.2
	app-text/yelp-tools:0
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.50.1
	sys-devel/gettext
	virtual/pkgconfig"

src_configure() {
	DOCS="AUTHORS README"
	gnome2_src_configure \
		--disable-tests \
		--enable-pixbuf \
		--enable-pdf \
		--enable-previewer \
		--enable-thumbnailer \
		$(use_with gnome-keyring keyring) \
		$(use_enable comics) \
		$(use_enable dbus) \
		$(use_enable djvu) \
		$(use_enable dvi) \
		$(use_enable epub) \
		$(use_enable introspection) \
		$(use_enable postscript ps) \
		$(use_enable t1lib) \
		$(use_enable tiff) \
		$(use_enable xps)
}
