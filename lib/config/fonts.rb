include Java

module Configuration
	

	import java.awt.Font;

	def updateTextBoxFont textArea
		fName = getProperty "font_name", "Arial"
		fSize = getProperty "font_size", "16"
		f = Font.new fName, Font::PLAIN, fSize.to_i

		textArea.setFont f
	end

	def chooseFont
		#TODO: Font and size picker!
		
	end
end
