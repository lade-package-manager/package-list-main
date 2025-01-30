#!/bin/sh

echo -n "package name? "
read pkgname
echo -n "version? "
read version
echo -n "description? "
read desc
echo -n "license? "
read license
echo -n "authors? "
read authors
echo -n "dependencies? (comma-separated) "
read depends
echo -n "repository? "
read repo
echo -n "download? (y/n) "
read download

mkdir -p "$pkgname"

cat <<EOF > "$pkgname/info.toml"
name = "$pkgname"
version = "$version"
description = "$desc"
license = "$license"
authors = [$(echo "$authors" | sed 's/, */", "/g' | sed 's/^/"/' | sed 's/$/"/')]
dependencies = [$(echo "$depends" | sed 's/, */", "/g' | sed 's/^/"/' | sed 's/$/"/')]
repository = "$repo"
EOF

if [ "$download" = "y" ]; then
    echo "download = true" >> "$pkgname/info.toml"
fi

