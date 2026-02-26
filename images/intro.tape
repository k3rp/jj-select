# Output configuration
Output jj-select-intro.gif
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
# Add the current directory to PATH so it can find jj-select
Type "export PATH=$PWD:$PATH" Enter

# Navigate into the most recently created demo repo!
Type "cd $(ls -td /tmp/jj-demo-* | head -1)/demo-repo" Enter

# 🔥 THE FIX: Deterministically reset the working copy to our starting commit!
Type 'jj edit "description(\"style(ui): update primary button hover states\")"' Enter

# Apply the clean, neutral PS1 prompt
Type 'export PS1="\[\033[1;37m\]\W\[\033[0m\] $ "' Enter

# Clear the screen before showing the recording
Type "clear" Enter
Show

# --- 2. Show the graph ---
Sleep 75ms
Type "jj log" Enter
Sleep 1500ms
Type "q"

# --- 3. Run jj-select ---
Type "jj select" Enter
Sleep 800ms

# --- 4. Fast TUI Interaction ---
# Zip up to the top of the stack
Up 1
Sleep 300ms
Up 1
Sleep 150ms
Enter 1
Sleep 300ms

Type "jj select" Enter
Sleep 350ms
# Zip down past the working copy
Down 1
Sleep 300ms
Down 1
Sleep 150ms
Down 1
Sleep 150ms
Down 1
Sleep 150ms
Enter 1
Sleep 150ms
Enter 1
Sleep 300ms

Type "jj select" Enter
Sleep 350ms
Up 1
Sleep 100ms
Up 1
Sleep 100ms
Up 1
Sleep 100ms
Up 1
Sleep 125ms
Up 1
Sleep 150ms
Enter 1
Sleep 300ms

# --- 5. Result ---
Sleep 500ms
