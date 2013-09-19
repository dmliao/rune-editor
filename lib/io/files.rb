include Java

import javax.swing.JFileChooser
import javax.swing.JOptionPane
import java.nio.file.Paths
import java.nio.file.Files
import java.io.BufferedReader
import java.io.FileReader
import java.io.BufferedWriter
import java.io.FileWriter
import java.io.OutputStreamWriter
import java.io.FileOutputStream
import java.lang.System

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
				doc = textPane.getStyledDocument
				while line != nil
					ls = System.getProperty "line.separator"
					textPane.addContent line + ls
					line = reader.readLine
				end
				@openFile = file.getPath
			end
		end

	end

	def saveDocument textPane, frame
		fileChooser = JFileChooser.new
		returnVal = fileChooser.showSaveDialog frame
		if returnVal == JFileChooser::APPROVE_OPTION
			out = nil
			begin
				file = fileChooser.getSelectedFile

				if file.isFile
					dialogResult = JOptionPane.showConfirmDialog frame, "Overwrite existing file?","Overwrite",JOptionPane::YES_NO_OPTION
					if (dialogResult == JOptionPane::YES_OPTION)
						writeDocument file,textPane
					end
				else
					writeDocument file,textPane
				end	
			rescue IOException
			end
		end
	end

	def writeDocument file, textPane
		begin
			fw = FileOutputStream.new file.getPath
			osw = OutputStreamWriter.new fw, "utf-8"
			out = BufferedWriter.new osw
			out.write textPane.getContent

			out.close
		rescue IOException
		end
	end


end