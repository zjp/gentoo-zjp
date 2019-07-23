# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

masters = gentoo

DESCRIPTION="A lightweight Wayland notification daemon."
HOMEPAGE="https://github.com/emersion/mako"
SRC_URI="https://github.com/emersion/${PN}/releases/download/v${PV}/${P}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gdk-pixbuf"

DEPEND="dev-libs/wayland
		x11-libs/pango
		x11-libs/cairo
		gdk-pixbuf? (x11-libs/gdk-pixbuf)
		|| (sys-auth/elogind sys-apps/systemd)
		sys-apps/dbus"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/meson"
