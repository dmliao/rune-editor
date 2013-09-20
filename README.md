##RUNE_EDITOR

Features to implement:

Saving / Loading
PanDoc Markdown to RTF or whatever
Config windows (fonts, text pane, etc.)
Word Count / Word Goal
Find / Replace

Stretch Features:

Auto-save and then version controlling
Background and Background music
Create prompts
Break timer! Pomodoro?
Plugin System
Syntax Highlighting

Use Launch4j to make exe files!

Bugs:
JTextPane makes long uninterrupted strings create a horizontal scrollbar. Fix that.
HTMLText doesn't support line-height. Until then, I'll have to use plaintext, so no syntax highlighting.
Sometimes when opening files, words get cut off until window resize or editing

TODO:

Check if file has been changed since last save! (it's still broken a bit...)
Scrollbar colors as config properties
Key bindings as a keybindings.properties file