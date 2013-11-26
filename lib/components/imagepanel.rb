include Java

import javax.swing.JPanel

import java.awt.Image
import java.awt.Dimension

import javax.imageio.ImageIO


class ImagePanel < JPanel
	@image = nil

	def initialize
		@image = false;
	end

	def setImage img
		file = java.io.File.new img
		if (file.exists)
			@image = ImageIO.read file
		else
			@image = false;
		end
	end

	def getScaleFactor masterSize, targetSize
		dScale = targetSize.to_f / masterSize.to_f

		return dScale
	end
	def getScaleFactorToFill masterSize, targetSize
		dScaleWidth = getScaleFactor masterSize.width.to_f, targetSize.height.to_f
		dScaleHeight = getScaleFactor masterSize.height.to_f, targetSize.height.to_f

		if (dScaleWidth>dScaleHeight)
			return dScaleWidth
		else
			return dScaleHeight
		end
	end
	def paintComponent g 
		if @image != false
			img = @image
			
			g.drawImage(img, 0, 0, getWidth(), getHeight(), self)
		else
			super g
		end
	end
end