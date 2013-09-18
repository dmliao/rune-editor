include Java

module Configuration

	def updateTextAreaBoundaries textArea, headerPanel, footerPanel
		bounds = getProperty "padding", "48"
		textArea.setBorder EmptyBorder.new 0,bounds.to_i,0,bounds.to_i
		footerPanel.setBorder EmptyBorder.new bounds.to_i,0,0,0
		headerPanel.setBorder EmptyBorder.new 0,0,bounds.to_i,0
	end

	def updateTextAreaColor mainPanel
	
		r = getProperty "textAreaRed", "255"
		g = getProperty "textAreaGreen", "255"
		b = getProperty "textAreaBlue", "255"
		opacity = getProperty "textAreaOpacity", "255"

		mainPanel.setBackground Color.new r.to_i,g.to_i,b.to_i,opacity.to_i		
	end

	def getTextAreaColor
	
		r = getProperty "textAreaRed", "255"
		g = getProperty "textAreaGreen", "255"
		b = getProperty "textAreaBlue", "255"
		opacity = getProperty "textAreaOpacity", "255"

		return Color.new r.to_i,g.to_i,b.to_i,opacity.to_i		
	end
	
end
