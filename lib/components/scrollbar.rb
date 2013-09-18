include Java

import javax.swing.plaf.basic.BasicScrollBarUI
import javax.swing.JButton
import javax.swing.JScrollPane
import java.awt.Color

class ScrollBarUI < BasicScrollBarUI
	@barThickness = 4
	def setStyle thickness
		@barThickness = thickness
	end

	def paintTrack g, c, trackBounds
		g.setColor Color.new 0,0,0,24
		g.fillRect 0,0,@barThickness,trackBounds::height
	end

	def paintThumb g, c, thumbBounds
		if thumbBounds.isEmpty
			return
		end
		g.translate thumbBounds::x, thumbBounds::y
		g.setColor Color.new 64,64,64,255
		g.fillRect 0,0,@barThickness,thumbBounds::height
	end

	def createDecreaseButton orientation
		return createZeroButton
	end
	def createIncreaseButton orientation
		return createZeroButton
	end

	def createZeroButton
		jButton = JButton.new
		jButton.setPreferredSize Dimension.new 0,0
		jButton.setMinimumSize Dimension.new 0,0
		jButton.setMaximumSize Dimension.new 0,0
		return jButton
	end
end

class RuneScrollPane < JScrollPane 

	def initialize view
		super view
		thickness = 8

		ui = ScrollBarUI.new
		ui.setStyle thickness

		self.getVerticalScrollBar.setUI ui

		self.getVerticalScrollBar.setPreferredSize Dimension.new thickness,self.getVerticalScrollBar.getSize.height
	end
end