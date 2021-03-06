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
* Undo / Redo
* Word Count

### Immediate Plans

* Settings pane to change the config file in the program
* Git integration

### Future Plans

* Markdown implementation
* Using PanDoc (or other converter) to export RTF files
* Find / Replace
* Fix styles to be more consistent with Ruby standards
* ???

## Dependencies

In order to run this at the moment, you will need jRuby. I haven't tested which versions work, but the latest download should build this project fine.

This project uses the (no longer updated) Flamingo JRibbon library, which has been included in JAR form in the java folder.

## Known Bugs
* JTextPane makes long uninterrupted strings create a horizontal scrollbar.
* HTMLText doesn't support line-height. Until then, I'll have to use plaintext, so no syntax highlighting.
* Sometimes when opening files, words get cut off until window resize or editing
* Version viewer errors out when you open a file that doesn't have any versions