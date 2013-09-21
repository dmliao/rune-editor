# Rune Editor

A simple plaintext editor written in Ruby, interpreted with JRuby. 

Pretty bare-bones at the moment, as it is primarily written as a learning project. Feel free to dissect and use it, but I'd advise against using it for any important work.

Note that this is written by a complete beginner, who's still learning the basics of Ruby and structuring code.The code may drastically change structure as this project continues.

## How to Run

Using JRuby in the command line:

    jruby lib/app.rb

This may change in future updates.

## Features

* Plaintext editing
* New, Open, and Save documents
* External config file to set the text editor's styles
* Uses Flamingo's JRibbon to create a top ribbon interface

### Immediate Plans

* (Belatedly) figure out unit testing
* Markdown implementation
* Word Count
* Undo / Redo
* Keybindings for keyboard shortcuts

### Future Plans

* Settings pane to change the config file in the program
* Using PanDoc (or other converter) to export RTF files
* Find / Replace
* Fix styles to be more consistent with Ruby standards
* ???

## Dependencies

This project uses the (no longer updated) Flamingo JRibbon library, which has been included in JAR form in the java folder.

## Known Bugs
* JTextPane makes long uninterrupted strings create a horizontal scrollbar.
* HTMLText doesn't support line-height. Until then, I'll have to use plaintext, so no syntax highlighting.
* Sometimes when opening files, words get cut off until window resize or editing
