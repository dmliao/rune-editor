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

This project uses the (no longer updated) Flamingo JRibbon library, which has been included in JAR form.

The Flamingo library is licensed under the BSD-License, reproduced here:

> Copyright (c) <YEAR>, <OWNER>
> All rights reserved.
>
> Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
>
> Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
> Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
> Neither the name of the <ORGANIZATION> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Known Bugs
* JTextPane makes long uninterrupted strings create a horizontal scrollbar.
* HTMLText doesn't support line-height. Until then, I'll have to use plaintext, so no syntax highlighting.
* Sometimes when opening files, words get cut off until window resize or editing
