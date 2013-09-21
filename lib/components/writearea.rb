include Java
require 'java'
require_relative "../text/undo.rb"

include UndoRedo

import javax.swing.JTextPane
import java.awt.Color
import java.awt.Insets
import java.awt.RenderingHints
import java.io.IOException
import java.io.StringReader
import java.lang.StringBuffer
import javax.swing.text.html.HTMLEditorKit
import javax.swing.text.html.parser.ParserDelegator
import javax.swing.text.html.HTMLDocument
import javax.swing.text.SimpleAttributeSet
import javax.swing.text.StyleConstants
import javax.swing.text.BadLocationException
import javax.swing.text.DefaultCaret

# TODO
# add key bindings and store getText to @content every time
# Then, we can pass the content into a save file!
class WriteArea < JTextPane

	@content = nil # the text content of the pane
	@edited = nil # whether the textpane has been edited since the last time this was checked
	@parser = nil # HTMLParser (unused)
	@editorKit = nil # the style editor for an HTML textpane (unused)
	@caret = nil # the caret used in the text pane

	def initialize
		super
		@editorKit = HTMLEditorKit.new

		@edited = false

		#self.setContentType 'text/html'
		self.setOpaque false
		#self.setEditorKit @editorKit
		self.setBackground Color.new 0,0,0,0

		@content = ''
		@parser = HTML2Text.new
		@caret = TextCaret.new

		@caret.setBlinkRate 500

		self.setCaret @caret

		docListener = SimpleDocumentListener.new do
			@edited = true
			puts "Edited"
		end
		self.getDocument.addDocumentListener docListener

		resetEdited

	end

	def resetEdited
		@edited = false
	end

	def getEdited
		return @edited
	end

	def setStyle font, spacing, paragraphSpacing
		self.setFont font

		#bodyRule = "body { font-family: " + font.getFamily + "; " + "font-size: " + font.getSize.to_s + "pt; }"
		#line height and paragraph spacing
		set = SimpleAttributeSet.new self.getParagraphAttributes
		StyleConstants.setLineSpacing set, spacing.to_f
		StyleConstants.setSpaceBelow set,paragraphSpacing.to_f

		#paraRule = "p {margin-bottom: " + paragraphSpacing + "em; line-height: " + spacing + "em; }"

		#@editorKit.getStyleSheet.addRule bodyRule
		#@editorKit.getStyleSheet.addRule paraRule

		#self.setEditorKit @editorKit

		@caret.setHeight font.getSize

		self.setParagraphAttributes set, false
	end


	def paintComponent g
		g.setColor getBackground
        g.fillRect 0, 0, getWidth, getHeight
        graphics2d = g
        graphics2d.setRenderingHint RenderingHints::KEY_TEXT_ANTIALIASING,RenderingHints::VALUE_TEXT_ANTIALIAS_ON
        graphics2d.setRenderingHint RenderingHints::KEY_RENDERING, RenderingHints::VALUE_RENDER_QUALITY
		super
	end

	def updateContent
		@content = self.getStyledDocument.getText 0, self.getStyledDocument.getLength
	end

	def parserGetContent
		@parser.parse StringReader.new self.getText
		return @parser.getText
	end
	def getContent
		return @content
	end

	def setContent content
		@content = content
		self.setText @content
	end

	def addContent content
		self.getStyledDocument.insertString self.getStyledDocument.getLength, content, nil
		updateContent
	end

	def clearContent
		self.setText ""
		updateContent
	end

end

# Custom caret to fix line height issues
class TextCaret < DefaultCaret

	@height = 16

	def setHeight height
		@height = height
	end

	def paint g
		comp = self.getComponent
		if comp == nil
			return
		end

		r = nil
		begin
			r = comp.modelToView getDot
			if r == nil
				return
			end
		rescue BadLocationException
			return
		end
		if isVisible
			g.fillRect r::x, r::y, 1, @height
		end
	end

end


# Helper class to convert HTML to plaintext
# Not needed right now, because everything IS plaintext
# Will be needed when I implement syntax highlighting
class HTML2Text < HTMLEditorKit::ParserCallback
	@s = nil
	def initialize
	end

	def parse input
		@s = StringBuffer.new
		delegator = ParserDelegator.new
		delegator.parse input, self, true
	rescue IOException
	end

	def handleText text, pos
		@s.append text
		@s.append '\n'
	end

	def getText
		return @s.toString
	end
end

##Helper class implementing DocumentListener to check if the textpane has been edited
# Simple implementation of javax.swing.event.DocumentListener that
# enables specifying a single code block that will be called
# when any of the three DocumentListener methods are called.
#
# Note that unlike Java, where it is necessary to subclass the abstract
# Java class SimpleDocumentListener, we can merely create an instance of
# the Ruby class SimpleDocumentListener with the code block we want
# executed when a DocumentEvent occurs.   This code can be in the form of
# a code block, lambda, or proc.
 
import javax.swing.event.DocumentListener
 
class SimpleDocumentListener

	# This is how we declare that this class implements the Java
	# DocumentListener interface in JRuby:
	include DocumentListener

	attr_accessor :behavior

	def initialize(&behavior)
		self.behavior = behavior
	end

	def changedUpdate(event)
		behavior.call event; 
	end
	def insertUpdate(event)  
		behavior.call event; 
	end
	def removeUpdate(event)   
		behavior.call event; 
	end

end