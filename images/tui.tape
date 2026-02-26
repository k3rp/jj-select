# Output configuration
Output jj-select-tui.gif
Set FontSize 20
Set Width 1000
Set Height 400
Set TypingSpeed 50ms 
Set Padding 20
Set Theme { "background": "#000000", "foreground": "#EEEEEC", "cursor": "#BBBBBB", "black": "#2E3436", "red": "#CC0000", "green": "#4E9A06", "yellow": "#C4A000", "blue": "#3465A4", "magenta": "#75507B", "cyan": "#06989A", "white": "#D3D7CF", "brightBlack": "#555753", "brightRed": "#EF2929", "brightGreen": "#8AE234", "brightYellow": "#FCE94F", "brightBlue": "#729FCF", "brightMagenta": "#AD7FA8", "brightCyan": "#34E2E2", "brightWhite": "#EEEEEC" }
Set WindowBar Rings

# Ensure dependencies are available
Require jj
Require gum
Require fzf
Require tmux

# --- 1. Setup (Hidden from the GIF) ---
Hide
Type "export PATH=$PWD:$PATH" Enter
Type "cd $(ls -td /tmp/jj-demo-* | head -1)/demo-repo" Enter
# Deterministically reset the working copy
Type 'jj edit "description(\"style(ui): update primary button hover states\")"' Enter
Type 'export PS1="\[\033[1;37m\]\W\[\033[0m\] $ "' Enter
Type "clear" Enter
Show

# --- 2. Default (Gum) ---
Sleep 75ms
Type "jj select" Enter
Sleep 800ms
Down 3
Sleep 300ms
Enter
Sleep 600ms

# --- 3. FZF Backend ---
Type "jj select -t fzf" Enter
Sleep 800ms
Down 2
Sleep 300ms
Type "style" 
Sleep 750 ms
Enter
Sleep 600ms

# --- 4. Enter Tmux ---
Type "tmux" Enter
Sleep 200ms

# Hide briefly to fix the PS1 prompt inside the new Tmux shell!
Hide
Type "bash" Enter
Type 'export PS1="\[\033[1;37m\]\W\[\033[0m\] $ "' Enter
Type "clear" Enter
Type "top" Enter
Sleep 200ms
Type "q" Enter
Sleep 75ms
Show

# --- 5. Tmux Split (gum_tmux) ---
Type "jj select -t gum_tmux" Enter
# Give it a second so the user can see the beautiful pane split
Sleep 1s
Down 1
Sleep 300ms
Enter

# Leave it on screen long enough to see the pane close and return to normal
Sleep 2s
