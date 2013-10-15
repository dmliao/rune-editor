include Java

import javax.swing.plaf.basic.BasicScrollBarUI
import javax.swing.JButton
import javax.swing.JScrollPane
import java.awt.Color

class ScrollBarUI < BasicScrollBarUI
	@barThickness = 4
	@trackColor = nil
	@thumbColor = nil
	def setStyle thickness, trackColor, thumbColor
		@barThickness = thickness
		@trackColor = trackColor
		@thumbColor = thumbColor
	end

	def paintTrack g, c, trackBounds
		g.setColor @trackColor
		g.fillRect 0,0,trackBounds::width,trackBounds::height
	end

	def paintThumb g, c, thumbBounds
		if thumbBounds.isEmpty
			return
		end
		g.translate thumbBounds::x, thumbBounds::y
		g.setColor @thumbColor
		g.fillRect 0,0,thumbBounds::width,thumbBounds::height
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

		trackColor = Color.new 0,0,0,24
		thumbColor = Color.new 0,0,0,128

		ui = ScrollBarUI.new
		ui.setStyle thickness, trackColor, thumbColor

		horUI = ScrollBarUI.new
		horUI.setStyle thickness, trackColor, thumbColor

		self.getVerticalScrollBar.setUI ui
		self.getHorizontalScrollBar.setUI horUI

		self.getVerticalScrollBar.setOpaque false
		self.getHorizontalScrollBar.setOpaque false

		self.getVerticalScrollBar.setPreferredSize Dimension.new thickness,self.getVerticalScrollBar.getSize.height
		self.getHorizontalScrollBar.setPreferredSize Dimension.new self.getHorizontalScrollBar.getSize.width,thickness
	end
end

class RepaintListener
	include java.awt.event.AdjustmentListener
	@frame = nil
	def initialize frame
		@frame = frame
	end
	def adjustmentValueChanged e
		@frame.repaint
	end
end

