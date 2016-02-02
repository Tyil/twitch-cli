#!/usr/bin/env sh

BASE_DIR=$(dirname "$0")
DEFAULT_INSTALL_DIR=${HOME}/.local/bin

usage()
{
	cat <<- EOF
		Usage: $0 <install|update|remove> [install dir]
	EOF
}

error_cd()
{
	echo "Error switching to directory $1"
	exit 1
}

install()
{
	# set a default installation location
	install_dir=${DEFAULT_INSTALL_DIR}

	# if a custom installdir was given, use that instead
	if [ -x "$1" ]; then
		install_dir=$1
	fi

	if [ ! -d "${install_dir}" ]; then
		mkdir -p "${install_dir}"
	fi

	cp twitch "${install_dir}/"
	cp integration/rofi "${install_dir}/twitch_rofi"
}

remove()
{
	# set a default installation location
	install_dir=${DEFAULT_INSTALL_DIR}

	# if a custom installdir was given, use that instead
	if [ -x "$1" ]; then
		install_dir=$1
	fi

	rm "${install_dir}/twitch"
	rm "${install_dir}/twitch_rofi"
}

update()
{
	# save the current working directory
	pwd=$(pwd)

	# set a default installation location
	install_dir=${DEFAULT_INSTALL_DIR}

	# if a custom installdir was given, use that instead
	if [ -x "$1" ]; then
		install_dir=$1
	fi

	cd "${BASE_DIR}" || error_cd "${BASE_DIR}"
	git pull origin master
	cp -f "${BASE_DIR}/twitch" "${install_dir}/"

	# get back to our original place
	cd "${pwd}" || error_cd "${pwd}"
}

main()
{
	if [ $# -lt 1 ]; then
		usage

		exit 1
	fi

	case "$1" in
		"update")
			update "$2"
		;;
		"install")
			install "$2"
		;;
		"remove")
			remove "$2"
		;;
		*)
			usage

			exit 1
	esac

	exit 0
}

main "$@"

