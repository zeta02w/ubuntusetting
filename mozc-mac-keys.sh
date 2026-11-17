#!/usr/bin/env bash
# mozc-mac-keys.sh : 無変換=IME OFF / 変換=IME ON 用のキーマップを用意して設定画面を開く
set -e

KEYMAP="$HOME/mozc-mac-keys.tsv"

printf '%s\t%s\t%s\n' \
  DirectInput    Henkan    IMEOn \
  Precomposition Henkan    IMEOn \
  Precomposition Muhenkan  IMEOff \
  Composition    Muhenkan  IMEOff \
  Conversion     Muhenkan  IMEOff \
  Suggestion     Muhenkan  IMEOff \
  Prediction     Muhenkan  IMEOff \
  > "$KEYMAP"

# クリップボードへコピー(入っていれば)
if command -v wl-copy >/dev/null; then wl-copy < "$KEYMAP"
elif command -v xclip >/dev/null; then xclip -selection clipboard < "$KEYMAP"
fi

echo "キーマップを $KEYMAP に保存しました(クリップボードにもコピー済み)"

# Mozc設定画面を開く
MOZC_TOOL=$(command -v mozc_tool || echo /usr/lib/mozc/mozc_tool)
"$MOZC_TOOL" --mode=config_dialog &
