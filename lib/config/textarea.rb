include Java

# Configuration module for setting the properties of the text area
# Slide this module into the main app, which can access the textPanel
# Requires the rest of the configuration module to work.
module Configuration

	# Updates the padding around the text area
	# Specific to this app, as it uses a header and a footer panel
	# +textArea+ - the textArea to set boundaries around
	# +headerPanel+ - a panel right above the textArea, for padding purposes
	# +footerPanel+ - a panel right below the textArea, for padding purposes
	def updateTextAreaBoundaries textArea, headerPanel, footerPanel
		bounds = getProperty "padding", "48"
		textArea.setBorder EmptyBorder.new 0,bounds.to_i,0,bounds.to_i
		footerPanel.setBorder EmptyBorder.new bounds.to_i,0,0,0
		headerPanel.setBorder EmptyBorder.new 0,0,bounds.to_i,0
	end

	# Updates the color of a specific panel based on the configuration properties
	# +panelToColor+ - the panel we want to set the background color of.
	def updateTextAreaColor panelToColor
	
		r = getProperty "textAreaRed", "255"
		g = getProperty "textAreaGreen", "255"
		b = getProperty "textAreaBlue", "255"
		opacity = getProperty "textAreaOpacity", "255"

		panelToColor.setBackground Color.new r.to_i,g.to_i,b.to_i,opacity.to_i		
	end

	# Get the color that the config file provides
	# +returns+ - the color cast to a Java Color object
	def getTextAreaColor
	
		r = getProperty "textAreaRed", "255"
		g = getProperty "textAreaGreen", "255"
		b = getProperty "textAreaBlue", "255"
		opacity = getProperty "textAreaOpacity", "255"

		return Color.new r.to_i,g.to_i,b.to_i,opacity.to_i		
	end

	# Updates the color of a scrollbar based on the configuration properties
	# +scrollBar+ - the scrollbar to update the color of
	# FIXME: Actually implement this!
	def updateScrollbarStyle scrollBar
	end
	
end
