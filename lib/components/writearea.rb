include Java
require 'java'

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

	@content = nil
	@parser = nil
	@editorKit = nil
	@caret = nil

	def initialize
		super
		@editorKit = HTMLEditorKit.new

		#self.setContentType 'text/html'
		self.setOpaque false
		#self.setEditorKit @editorKit
		self.setBackground Color.new 0,0,0,0

		@content = ''
		@parser = HTML2Text.new
		@caret = TextCaret.new

		@caret.setBlinkRate 500

		self.setCaret @caret

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