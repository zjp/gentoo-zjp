# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools out-of-source git-r3

DESCRIPTION="i3 fork with gaps and rounded corners"
HOMEPAGE="https://github.com/resloved/i3"
EGIT_REPO_URI="https://github.com/resloved/i3/"
EGIT_BRANCH="shape"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="
dev-libs/glib:2
dev-libs/libev
dev-libs/libpcre
dev-libs/yajl
x11-libs/cairo[X,xcb]
x11-libs/libxcb[xkb]
x11-libs/libxkbcommon[X]
x11-libs/pango[X]
x11-libs/startup-notification
x11-libs/xcb-util
x11-libs/xcb-util-cursor
x11-libs/xcb-util-keysyms
x11-libs/xcb-util-wm
x11-libs/xcb-util-xrm
"
BDEPEND="
app-text/asciidoc
app-text/xmlto
dev-lang/perl
virtual/pkgconfig
"
RDEPEND="${DEPEND}
dev-lang/perl
dev-perl/AnyEvent-I3
dev-perl/JSON-XS
!x11-wm/i3
!x11-wm/i3-gaps
"

DOCS=( RELEASE-NOTES-9999)

PATCHES=( "${FILESDIR}/${PN}-4.16-musl-GLOB_TILDE.patch" )

src_prepare() {
default
eautoreconf
cat <<- EOF > "${T}"/i3wm
#!/bin/sh
exec /usr/bin/i3
EOF
}

my_src_configure() {
# disable sanitizer: otherwise injects -O0 -g
local myeconfargs=(
$(use_enable doc docs)
--enable-debug=no
--enable-mans
--disable-sanitizers
)
econf "${myeconfargs[@]}"
}

src_compile() {
emake -C "${WORKDIR}/${P}_build"
}

my_src_install_all() {
emake -C "${WORKDIR}/${P}_build" DESTDIR="${D}" install

exeinto /etc/X11/Sessions
doexe "${T}"/i3wm
}

pkg_postinst() {
einfo "There are several packages that you may find useful with ${PN} and"
einfo "their usage is suggested by the upstream maintainers, namely:"
einfo "  x11-misc/dmenu"
einfo "  x11-misc/i3lock"
einfo "  x11-misc/i3status"
einfo "Please refer to their description for additional info."
}
