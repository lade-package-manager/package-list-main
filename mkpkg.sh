#!/bin/sh

echo -n "package name? "
read pkgname
echo -n "older_version? (y/n) "
read older_y_n
echo -n "version? "
read version
echo -n "description? "
read desc
echo -n "license? "
read license
echo -n "authors? (comma-separated) "
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
older_version = [$(echo "$older_version" | sed 's/, */", "/g' | sed 's/^/"/' | sed 's/$/"/')]
description = "$desc"
license = "$license"
authors = [$(echo "$authors" | sed 's/, */", "/g' | sed 's/^/"/' | sed 's/$/"/')]
dependencies = [$(echo "$depends" | sed 's/, */", "/g' | sed 's/^/"/' | sed 's/$/"/')]
repository = "$repo"
EOF

if [ "$download" = "y" ]; then
    echo -n "url? "
    read url
    echo "download = \"$url\"" >> "$pkgname/info.toml"
fi

if [ "$older_y_n" = "y" ]; then
    echo -n "older_version? (comma-separated) "
    read older
    echo "dependencies = [$(echo "$older" | sed 's/, */", "/g' | sed 's/^/"/' | sed 's/$/"/')]" >> "$pkgname/info.toml"
fi

