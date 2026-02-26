#!/usr/bin/env bash
set -euo pipefail

TEST_DIR=$(mktemp -d -t jj-demo-XXXXXX)
echo "🎬 Creating demo repository in: $TEST_DIR"

# 1. Setup Remote
REMOTE_DIR="$TEST_DIR/remote.git"
git init --bare "$REMOTE_DIR" --quiet

# 2. Setup Local & Colocate
LOCAL_DIR="$TEST_DIR/demo-repo"
mkdir -p "$LOCAL_DIR"
cd "$LOCAL_DIR"

git init --quiet
git remote add origin "$REMOTE_DIR"
jj git init --colocate

# Configure deterministic user
jj config set --repo user.name "k3rp"
jj config set --repo user.email "k3rp@github.com"

# 🔥 Strictly lock down the bases
jj config set --repo 'revset-aliases."immutable_heads()"' 'bookmarks(exact:"main") | bookmarks(exact:"feature_branch")'

echo "Building the base (main)..."
jj describe --reset-author -m "docs: add initial architecture README"
echo "# Project Architecture" > README.md
jj bookmark create main
jj git push --remote origin --bookmark main

echo "Building the secondary base (feature_branch)..."
jj new main -m "chore: setup feature flag framework"
echo "FEATURE_FLAGS_ENABLED=true" > config.env
jj bookmark create feature_branch
jj git push --remote origin --bookmark feature_branch


# --- Stack 1: API Authentication (Base: main) ---
echo "🔐 Building API Auth stack..."
jj new main -m "feat(api): add JWT validation middleware"
echo "const jwt = require('jsonwebtoken');" > auth.js
jj bookmark create api_auth

jj new -m "feat(api): integrate Google OAuth provider"
echo "const googleStrategy = new OAuth2Strategy();" >> auth.js

jj new -m "docs(api): update swagger specs for auth endpoints"
echo "openapi: 3.0.0" > swagger.yaml


# --- Stack 2: Database Migration (Base: main) ---
echo "🌱 Building Database Migration stack..."
jj new main -m "chore(db): initialize user profiles table"
echo "CREATE TABLE profiles (id INT);" > db_init.sql
jj bookmark create db_migration

jj new -m "feat(db): add indexing to email column"
echo "CREATE INDEX idx_email ON profiles(email);" >> db_init.sql

jj new -m "fix(db): resolve foreign key constraint on deletion"
echo "-- Fixed cascade deletion" >> db_init.sql


# --- Stack 3: UI Overhaul (Base: feature_branch) ---
# Now significantly longer to show off the stack selection!
echo "🎨 Building UI Overhaul stack..."
jj new feature_branch -m "feat(ui): scaffold new dashboard layout"
echo "<div class='dashboard'></div>" > dashboard.html
jj bookmark create ui_redesign

jj new -m "feat(ui): implement dark mode toggle component"
echo "function toggleTheme() {}" > theme.js

jj new -m "style(ui): update primary button hover states"
echo ".btn:hover { background: #333; }" > styles.css

jj new -m "fix(ui): correct flexbox alignment on mobile viewport"
echo "@media (max-width: 600px) { .dashboard { flex-direction: column; } }" >> styles.css

jj new -m "feat(ui): add accessible aria labels to buttons"
echo "document.querySelectorAll('.btn').forEach(b => b.setAttribute('aria-label', 'button'));" > a11y.js

jj new -m "chore(ui): refactor CSS variables for themeing"
echo ":root { --bg: #fff; --text: #000; }" > vars.css


# --- Final Polish ---
# Move working copy 3 commits back from the top of the UI stack (@---)
# This places it perfectly in the middle with commits above and below it!
jj edit @---

echo ""
echo "✅ Demo repository ready! Run this to open it:"
echo "cd $LOCAL_DIR"
echo "------------------------------------------------"
jj log
