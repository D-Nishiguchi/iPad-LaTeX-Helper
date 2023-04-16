# iPad-LaTeX-Helper

これはMacでLaTeXでコンパイルされたpdfファイルをiCloudにコピーするシェルスクリプトです｡

カレントディレクトリもしくはカレントディレクトリ内のoutディレクトリから最新のpdf見つけ出しています｡

最新のpdfを指定している理由は図表がpdfファイルの場合間違って選択しないようにしているためです｡

正常に動作しない場合chmodで権限を変更してください｡

```bash
chmod -x copy_pdf.sh
```

```bash
./copy_pdf.sh
```

Ruby版もあります｡

お好きな方をお使いください｡

```bash
ruby copy_pdf.rb
```
