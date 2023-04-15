#!/bin/bash

# outディレクトリから最も新しいPDFファイルを探す
pdf_file=$(find ./out -type f -iname "*.pdf" -exec stat -f "%m %N" {} \; | sort -nr | head -n1 | cut -d' ' -f2-)

# outディレクトリにPDFファイルがない場合、カレントディレクトリから最も新しいPDFファイルを探す
if [ -z "$pdf_file" ]; then
    pdf_file=$(find . -maxdepth 1 -type f -iname "*.pdf" -exec stat -f "%m %N" {} \; | sort -nr | head -n1 | cut -d' ' -f2-)
fi

if [ -z "$pdf_file" ]; then
    echo "No PDF file found in the 'out' directory or the current directory."
    exit 1
fi

# 今日の日付を yyyy/mm/dd の形式で取得
today=$(date +"%Y/%m/%d")

# コピー先のディレクトリを指定
destination="$HOME/Library/Mobile Documents/com~apple~CloudDocs/buffer"

# PDF ファイルをコピーして名前を変更し、同じファイル名が存在する場合は上書き
if cp -f "$pdf_file" "$destination/${today//\//-}.pdf"; then
    echo "PDF file copied and renamed to '${today//\//-}.pdf' in the 'buffer' directory."
else
    echo "Failed to copy and rename the PDF file."
    exit 1
fi
