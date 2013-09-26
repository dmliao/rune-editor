include Java

import javax.swing.JPanel
import java.awt.Color

class TranslucentPanel < JPanel

	def initialize
		super
		setOpaque false
	end

	def paintComponent g
		g.setColor getBackground
		r = g.getClipBounds
        g.fillRect r.x, r.y, r.width, r.height
		super
	end

end