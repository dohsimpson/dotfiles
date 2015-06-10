#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SESSION_NAME="$1"

session_exists() {
	tmux has-session -t "$SESSION_NAME" >/dev/null 2>&1
}

dismiss_session_list_page_from_view() {
	tmux send-keys C-c
}

session_name_not_provided() {
	[ -z "$SESSION_NAME" ]
}

main() {
	if session_name_not_provided; then
		dismiss_session_list_page_from_view
		exit 0
	fi
	if session_exists; then
		dismiss_session_list_page_from_view
		tmux switch-client -t "$SESSION_NAME"
	else
		"$CURRENT_DIR/show_goto_prompt.sh" "$SESSION_NAME"
	fi
}
main
