#!/bin/bash

NEW_SESSION="$1"

# Check if the session name is purely a number.
[[ "$NEW_SESSION" =~ ^[0-9]+$ ]] || exit 0

# Find the lowest missing number by comparing a sequence to active numeric sessions
TARGET_NUM=$(comm -23 \
    <(seq 0 100) \
    <(tmux ls -F '#S' | grep -E '^[0-9]+$' | sort -n) \
    | head -n 1)

# If the target is smaller than the assigned number, rename the session
[[ "$TARGET_NUM" -lt "$NEW_SESSION" ]] && tmux rename-session -t "$NEW_SESSION" "$TARGET_NUM"
