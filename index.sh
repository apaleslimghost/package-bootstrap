#!/bin/sh

npm_bin="$(dirname "$0")"

files=$(env | grep npm_package_config_bootstrapFiles | cut -f 2 -d '=')
destination=${1:-$(pwd)}

copy_files() {
	local IFS=$'\n'
	for file in $files; do
		if [ ! -e "$destination/$file" ]; then
			cp "$file" "$destination/$file"
			echo "  │ $file installed"
		else
			echo "  │ $file exists, skipping"
		fi
	done
}

if $npm_bin/is-installing-package ; then
	echo "  ⎘ installing bootstrap files for $npm_package_name to $destination"
	copy_files
	echo "  ✔︎ done"
	echo
fi
