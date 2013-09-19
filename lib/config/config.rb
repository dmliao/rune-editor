include Java

module Configuration
	

	import java.io.FileInputStream;
	import java.io.FileOutputStream;
	import java.io.IOException;
	import java.util.Properties;

	@prop = nil
	@fos = nil

	def initProperties
		begin
			@prop = Properties.new
			@prop.load FileInputStream.new "config.properties"
		rescue IOException
			self.resetProperties
		end
	end

	def resetProperties
		@prop.setProperty "fontName","Alegreya"
		@prop.setProperty "fontSize","18"
		@fos = FileOutputStream.new "config.properties"
		@prop.store @fos,nil
	end

	def setProperty propertyKey, propertyValue
		@prop.setProperty propertyKey,propertyValue
		puts "SAVED PROPERTY"

		@fos = FileOutputStream.new "config.properties"

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

end