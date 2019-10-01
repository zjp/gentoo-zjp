# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit golang-base git-r3

DESCRIPTION="Command-line tool to customize Spotify client."
HOMEPAGE="https://github.com/khanhas/${PN}"
SRC_URI=""
EGIT_REPO_URI="${HOMEPAGE}"
EGIT_BRANCH="master"
EGO_PN="github.com/khanhas/{$PN}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND="media-sound/spotify" # spotify
RDEPEND="${DEPEND}"
BDEPEND="dev-vcs/git dev-lang/go" #git, go
