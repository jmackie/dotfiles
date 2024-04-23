# shellcheck shell=bash
fpath="$1"
pane_id=$(wezterm cli get-pane-direction right)
if [ -z "${pane_id}" ]; then
  pane_id=$(wezterm cli split-pane --right --percent 80 hx "$fpath")
else
  program=$(wezterm cli list | awk -v pane_id="$pane_id" '$3==pane_id { print $6 }')
  if [ "$program" != "hx" ]; then
    pane_id=$(wezterm cli split-pane --bottom --pane-id "$pane_id" hx "$fpath")
  else
    echo -e ":hsplit ${fpath}\r\n" | wezterm cli send-text --pane-id "$pane_id" --no-paste
  fi
fi
wezterm cli activate-pane-direction --pane-id "$pane_id" right
