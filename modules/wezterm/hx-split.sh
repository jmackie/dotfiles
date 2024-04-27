# shellcheck shell=bash
fpath="$1"
hx="${hx:-hx}"
pane_id=$(wezterm cli get-pane-direction right)
if [ -z "${pane_id}" ]; then
  # If there is no pane open to the right of the current one then open one
  pane_id=$(wezterm cli split-pane --right --percent 80 "$hx" "$fpath")
else
  # If there _is_ a pane open to the right, figure out what's running
  program=$(wezterm cli list | awk -v pane_id="$pane_id" '$3==pane_id { print $6 }')
  if [ "$program" = "hx" ]; then
    # If helix is running, then open a new horizontal split
    echo -e ":hsplit ${fpath}\r\n" | wezterm cli send-text --pane-id "$pane_id" --no-paste
  else
    # Otherwise open a new helix pane underneath whatever is running
    pane_id=$(wezterm cli split-pane --bottom --pane-id "$pane_id" "$hx" "$fpath")
  fi
fi
wezterm cli activate-pane-direction --pane-id "$pane_id" right
