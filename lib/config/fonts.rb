include Java

module Configuration
	

	import java.awt.Font;

	def updateTextBoxFont textArea
		fName = getProperty "fontName", "Arial"
		fSize = getProperty "fontSize", "16"
		lineSpacing = getProperty "lineSpacing", "1.5"
		paraSpacing = getProperty "paraSpacing", "32"
		f = Font.new fName, Font::PLAIN, fSize.to_i

		textArea.setStyle f, lineSpacing, paraSpacing
	end

	def chooseFont
		#TODO: Font and size picker!
		
	end
end
