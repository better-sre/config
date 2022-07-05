#!/bin/sh
# shellcheck shell=dash
# Copyright (c) 2021 better-sre. All rights reserved. MIT license.
# TODO(everyone): Keep this script simple and easily auditable.

##########################################################################
# ref:
#   - https://github.com/rust-lang/rustup/blob/master/rustup-init.sh
#   - https://github.com/denoland/deno_install
#   - https://github.com/metacall/install
#
##########################################################################



set -e


# TODO X: Need Sync Update this Version.
# download version:
DOWNLOAD_VERSION="v0.0.7"


main() {
	ensure check_os

	# create dir:
	ignore init_dir

	# clone this repo:
	ensure download

	# install go-task:
	ensure init_go_task

}

##########################################################################

ROOT_DIR="$HOME/.local/task/better-sre"

init_dir() {
  if [ ! -d "$ROOT_DIR" ]; then
    mkdir -p "$ROOT_DIR"
  fi
}


# https://github.com/better-sre/config/archive/refs/tags/v0.0.1.zip
download() {
	DOWNLOAD_BASE_URL="https://github.com/better-sre/config/archive/refs/tags"

	if [ $# -eq 0 ]; then
		DOWNLOAD_URL="${DOWNLOAD_BASE_URL}/${DOWNLOAD_VERSION}.zip"
	else
		DOWNLOAD_URL="${DOWNLOAD_BASE_URL}/${1}.zip"
	fi


	echo "download: ${DOWNLOAD_URL} to ${ROOT_DIR}"

	# clean: fix: 不可以加引号
	rm -rf ${ROOT_DIR}/*

	# download:
	curl --fail --location --progress-bar --output "${ROOT_DIR}/config.zip" "${DOWNLOAD_URL}"
	unzip -d "${ROOT_DIR}" -o "${ROOT_DIR}/config.zip"
	mv -f ${ROOT_DIR}/config-* ${ROOT_DIR}/config
	rm "${ROOT_DIR}/config.zip"
}

##########################################################################


check_os() {
	local os=$(uname)

	# TODO: Implement other operative systems in metacall/distributable-linux
	case ${os} in
		Darwin)
			echo "osx"
			return
			;;
		# FreeBSD)
		# 	echo "freebsd"
		# 	return
		# 	;;
		Linux)
			echo "linux"
			return
			;;
	esac

	err "Operative System detected (${os}) is not supported." \
		"  Please, try to use init.ps1 install script." \
		"  Aborting installation."
}



init_go_task(){
	# check:
	if ! check_cmd task; then
		echo "Not Found go-task, auto install."

		local os=$(uname)

		# TODO: Implement other operative systems in metacall/distributable-linux
		case ${os} in
			Darwin)
				echo "macos install:"
				brew install go-task/tap/go-task
				task --version
				return
				;;
			# FreeBSD)
			# 	echo "freebsd"
			# 	return
			# 	;;
			Linux)
				echo "linux"
				sudo snap install task --classic
				task --version
				return
				;;
		esac

		err "Detected (${os}) is not supported." \
			"  Please, try to use init.ps1 install script." \
			"  Aborting installation."
	fi

}


################################################################


say() {
    printf 'task + better-sre: %s\n' "$1"
}

err() {
    say "$1" >&2
    exit 1
}

need_cmd() {
    if ! check_cmd "$1"; then
        err "need '$1' (command not found)"
    fi
}

check_cmd() {
    command -v "$1" > /dev/null 2>&1
}

assert_nz() {
    if [ -z "$1" ]; then err "assert_nz $2"; fi
}

# Run a command that should never fail. If the command fails execution
# will immediately terminate with an error showing the failing
# command.
ensure() {
    if ! "$@"; then err "command failed: $*"; fi
}

# This is just for indicating that commands' results are being
# intentionally ignored. Usually, because it's being executed
# as part of error handling.
ignore() {
    "$@"
}


################################################################

# Run main
main