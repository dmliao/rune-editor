include Java

import javax.swing.JLabel
import java.awt.Color

class TransparentLabel < JLabel

	def initialize text
		super "ARRRGHHH"
		setOpaque false
	end

	def paintComponent g
		g.setColor getBackground
		g.fillRect 0,0,getWidth,getHeight
		super
	end

end