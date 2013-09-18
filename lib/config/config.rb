include Java

module Configuration
	

	import java.io.FileInputStream;
	import java.io.FileOutputStream;
	import java.io.IOException;
	import java.util.Properties;

	@prop = nil
	@fos = nil

	def initProperties
		@prop = Properties.new
		@prop.load FileInputStream.new "config.properties"
	rescue IOException
		self.resetProperties
	end

	def resetProperties
		@prop.setProperty "font_name","Alegreya"
		@prop.setProperty "font_size","18"
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