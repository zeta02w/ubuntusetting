#!/usr/bin/env bash
# 書き出した ms-ime.tsv に「無変換=IME OFF / 変換=IME ON」を足して mozc-mac.tsv を作る
set -e
IN="${1:-$HOME/ms-ime.tsv}"
OUT="$HOME/mozc-mac.tsv"

[ -f "$IN" ] || { echo "$IN が見つかりません。ステップ1を先に行ってください"; exit 1; }

# 重複エラーを避けるため、置き換える行だけ取り除く
awk -F'\t' 'NR==1 {print; next}
$2=="Muhenkan" {next}
$2=="Henkan" && ($1=="DirectInput" || $1=="Precomposition") {next}
{print}' "$IN" > "$OUT"

# 5行を追加
printf '%s\t%s\t%s\n' \
  DirectInput    Henkan   IMEOn \
  Precomposition Henkan   IMEOn \
  Precomposition Muhenkan IMEOff \
  Composition    Muhenkan IMEOff \
  Conversion     Muhenkan IMEOff \
  >> "$OUT"

echo "作成しました: $OUT"
