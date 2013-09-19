include Java

import javax.swing.JFileChooser
import java.nio.file.Paths
import java.nio.file.Files
import java.io.BufferedReader
import java.io.FileReader

module FilesIO
	@openFile = nil

	def createNewDocument textPane, frame
		@openFile = nil

	end

	def openDocument textPane, frame
		fileChooser = JFileChooser.new
		returnVal = fileChooser.showOpenDialog frame
		if returnVal == JFileChooser::APPROVE_OPTION
			file = fileChooser.getSelectedFile
			begin
				fr = FileReader.new file
				reader = BufferedReader.new fr
				line = reader.readLine
				while line != nil
					puts line
					line = reader.readLine
				end
			end
		end

	end

	def saveDocument textPane, frame

	end

end