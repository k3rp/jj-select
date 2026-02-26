#!/usr/bin/env bash
set -euo pipefail

sh create_fake_repo.sh
vhs intro.tape
vhs modes.tape
vhs rebase.tape
vhs tui.tape
