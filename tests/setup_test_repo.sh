#!/usr/bin/env bash
set -euo pipefail

TEST_DIR="/tmp/jj-demo-test-repo"

if [[ -d "$TEST_DIR" ]]; then
  echo "Demo repository already exists at: $TEST_DIR"
  exit 0
fi

echo "Creating demo repo in: $TEST_DIR"
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

jj git init . --quiet
jj config set --repo user.name "k3rp"
jj config set --repo user.email "k3rp@github.com"

jj describe -m "docs: add initial architecture README"
jj bookmark create main

jj new main -m "feat(api): add JWT validation middleware"
jj bookmark create api_auth
jj new -m "feat(api): integrate Google OAuth provider"

jj new main -m "feat(ui): scaffold new dashboard layout"
jj bookmark create ui_redesign
jj new -m "feat(ui): implement dark mode toggle component"
jj new -m "style(ui): update primary button hover states"
jj edit @-

echo "$TEST_DIR" > /tmp/jj_test_dir
echo "Demo repository ready at: $TEST_DIR"
