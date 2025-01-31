#!/bin/bash

version="1"
output_dir="./out"

if [ -e $output_dir ]; then
	rm -rf "$output_dir"
fi

mkdir -p "$output_dir"  # out ディレクトリを作成（存在してもOK）
current_time=$(date "+%Y-%m-%d-%H:%M:%S")

zip_name="$output_dir/main.zip"

# 現在のディレクトリ内のディレクトリを取得（outを除外）
dirs=()
for dir in */; do
    if [ -d "$dir" ] && [ "$dir" != "$output_dir/" ]; then
        dirs+=("$dir")  # 配列に追加
    fi
done

# ディレクトリが存在する場合のみ圧縮
if [ ${#dirs[@]} -gt 0 ]; then
    echo "Compressing directories into $zip_name..."
    zip -r "$zip_name" "${dirs[@]}"
    echo "Created: $zip_name"
    cat <<EOF > "$output_dir/info.json"
{
	"version": $version,
	"date": $current_time,
	"file": $zip_name,
}
EOF

else
    echo "No directories found to compress."
fi

