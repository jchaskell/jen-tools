#!/bin/bash

# Load .bashrc, which has common aliases and functions and loads extra
if [[ -r "${HOME}/.bashrc" ]]; then
	source "${HOME}/.bashrc"
fi
