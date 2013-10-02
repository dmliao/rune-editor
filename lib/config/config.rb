include Java

module Configuration
	

	import java.io.FileInputStream;
	import java.io.FileOutputStream;
	import java.io.IOException;
	import java.util.Properties;

	@prop = nil
	@fos = nil
	@filePath = nil

	def initProperties
		@filePath = __FILE__ + "/../../config.properties"
		begin
			@prop = Properties.new
			@prop.load FileInputStream.new @filePath
		rescue IOException
			self.resetProperties
		end
	end

	def resetProperties
		@prop.setProperty "fontName","Alegreya"
		@prop.setProperty "fontSize","18"
		@fos = FileOutputStream.new @filePath
		@prop.store @fos,nil
	end

	def setProperty propertyKey, propertyValue
		@prop.setProperty propertyKey,propertyValue
		puts "SAVED PROPERTY"

		@fos = FileOutputStream.new @filePath

		@prop.store @fos,nil
	end

	def getProperty propertyKey, default
		p = @prop.getProperty propertyKey
		if p == nil
			puts "NIL PROPERTY"
			setProperty propertyKey, default
		end
		return @prop.getProperty propertyKey
	end

	def exportProperties fPath
		fos = FileOutputStream.new fPath
		@prop.store fos, nil
	end

end