include Java

import javax.swing.JTextPane
import java.awt.Color
import java.awt.Insets
import java.awt.RenderingHints

class WriteArea < JTextPane
	def initialize
		super
		self.setOpaque false
		self.setBackground Color.new 0,0,0,0
	end

	def paintComponent g
		g.setColor getBackground
        g.fillRect 0, 0, getWidth, getHeight
        graphics2d = g
        graphics2d.setRenderingHint RenderingHints::KEY_ANTIALIASING,RenderingHints::VALUE_ANTIALIAS_ON
		super
	end
end
