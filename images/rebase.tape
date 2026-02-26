# Output configuration
Output jj-select-rebase.gif
Set FontSize 20
Set Width 1000
Set Height 820
Set TypingSpeed 50ms 
Set Padding 20
Set Theme { "background": "#000000", "foreground": "#EEEEEC", "cursor": "#BBBBBB", "black": "#2E3436", "red": "#CC0000", "green": "#4E9A06", "yellow": "#C4A000", "blue": "#3465A4", "magenta": "#75507B", "cyan": "#06989A", "white": "#D3D7CF", "brightBlack": "#555753", "brightRed": "#EF2929", "brightGreen": "#8AE234", "brightYellow": "#FCE94F", "brightBlue": "#729FCF", "brightMagenta": "#AD7FA8", "brightCyan": "#34E2E2", "brightWhite": "#EEEEEC" }
Set WindowBar Rings

# Ensure dependencies are available
Require jj
Require gum

# --- 1. Setup (Hidden from the GIF) ---
Hide
Type "export PATH=$PWD:$PATH" Enter
Type "cd $(ls -td /tmp/jj-demo-* | head -1)/demo-repo" Enter

# Deterministically reset the working copy to our starting commit in the UI stack
Type 'jj edit "description(\"style(ui): update primary button hover states\")"' Enter
Type 'export PS1="\[\033[1;37m\]\W\[\033[0m\] $ "' Enter
Type "clear" Enter
Show

# --- 2. Rebase onto a Remote ---
Sleep 75ms
Type "jj log" Enter
Sleep 2000ms
Type "q" Enter
Sleep 350ms
Type "jj select" Enter
Sleep 300ms
Down 1
Sleep 100ms
Down 1
Sleep 100ms
Enter 1
Sleep 400 ms

Type "jj select remotes rebase" Enter
Sleep 800ms
# Pick the 'main' remote to rebase the UI stack off of feature_branch and onto main
Down 1
Sleep 300ms
Enter 1
Sleep 1s

# --- 3. Rebase onto another Stack (via Log) ---
Type "jj select roots" Enter
Sleep 300ms
Down 1
Sleep 350ms
Enter 1
Type "jj select log rebase" Enter
Sleep 800ms
# Move down through the log to target the top of the Database Migration stack
Down 5
Sleep 150ms
Down 1
Sleep 150ms
Enter
Sleep 1s

# --- 4. Show the final graph! ---
Type "clear" Enter
Sleep 100ms
Type "jj log" Enter
# Leave it on screen long enough to marvel at the new graph
Sleep 4s
