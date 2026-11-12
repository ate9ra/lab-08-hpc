#!/bin/bash
set -euo pipefail

bucket="$1"
book_dir="$2"

mkdir -p "$book_dir"
book_dir="$(realpath "$book_dir")"
 
aws s3 cp "s3://$bucket" "$book_dir" --recursive --exclude "*" --include "*.txt"

echo "File path" > book_list.txt
find "$book_dir" -name "*.txt" | sort >> book_list.txt
 
n_books="$(tail -n +2 book_list.txt | wc -l)"
echo "Listed $n_books books in book_list.txt"
