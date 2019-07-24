# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
EAPI=6
# Used https://gpo.zugaina.org/AJAX/Ebuild/38346907/View
PYTHON_COMPAT=( python2_7 )
inherit git-r3 cmake-utils python-single-r1
DESCRIPTION="A fast, configurable status bar"
HOMEPAGE="https://github.com/jaagr/polybar"
EGIT_REPO_URI="https://github.com/jaagr/polybar"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa i3wm mpd curl network pulseaudio"
DEPEND="
x11-libs/libxcb[xkb]
x11-libs/cairo[xcb]
x11-base/xcb-proto
x11-libs/xcb-util-wm
x11-libs/xcb-util-image
x11-libs/xcb-util-wm
x11-libs/xcb-util-xrm
x11-libs/xcb-util-cursor
alsa? ( media-libs/alsa-lib )
mpd? ( media-libs/libmpdclient )
network? ( net-wireless/wireless-tools )
curl? ( net-misc/curl )
i3wm? ( dev-libs/jsoncpp )
pulseaudio? ( media-sound/pulseaudio )"
RDEPEND="${DEPEND}"
src_configure() {
	local mycmakargs=(
		-DENABLE_ALSA="$(usex alsa)"
		-DENABLE_MPD="$(usex mpd)"
		-DENABLE_NETWORK="$(usex network)"
		-DENABLE_I3="$(usex i3wm)"
		-DENABLE_CURL="$(usex curl)"
		-DENABLE_PULSEAUDIO="$(usex pulseaudio)"
	)
	cmake-utils_src_configure
}

