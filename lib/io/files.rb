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
		if textPane.getEdited == true
			dialogResult = JOptionPane.showConfirmDialog frame, "Do you want to save changes to this document?", "Confirm New", JOptionPane::YES_NO_CANCEL_OPTION
			if (dialogResult == JOptionPane::YES_OPTION)
				saved = saveDocument false, textPane, frame #Save the document first!
				if saved == true
					handleNewDocument textPane, frame
				end
			elsif (dialogResult == JOptionPane::NO_OPTION)
				handleNewDocument textPane, frame
			end
		end

	end

	protected
	def handleNewDocument textPane, frame
		@openFile = nil
		textPane.clearContent
		textPane.resetEdited
	end

	protected
	def handleOpenDocument textPane, frame
		fileChooser = JFileChooser.new
		returnVal = fileChooser.showOpenDialog frame
		if returnVal == JFileChooser::APPROVE_OPTION
			file = fileChooser.getSelectedFile
			begin
				readDocument file,textPane
				@openFile = file
			end
		else
			return false
		end
		return true
	end

	def openDocument textPane, frame
		if textPane.getEdited == true
			dialogResult = JOptionPane.showConfirmDialog frame, "Do you want to save changes to this document?", "Confirm Open", JOptionPane::YES_NO_OPTION
			if (dialogResult == JOptionPane::YES_OPTION)
				saveDocument false, textPane, frame #Save the document first!
				handleOpenDocument textPane, frame #recursively open another document!
			else	
				handleOpenDocument textPane, frame
			end
		else
			handleOpenDocument textPane, frame
		end
	end

	def saveDocument saveAs, textPane, frame

		textPane.updateContent
		if @openFile == nil || saveAs == true

			fileChooser = JFileChooser.new
			returnVal = fileChooser.showSaveDialog frame
			if returnVal == JFileChooser::APPROVE_OPTION
				out = nil
				begin
					file = fileChooser.getSelectedFile

					if file.isFile
						dialogResult = JOptionPane.showConfirmDialog frame, "Overwrite existing file?","Overwrite",JOptionPane::YES_NO_OPTION
						if (dialogResult == JOptionPane::YES_OPTION)
							writeDocument file.getPath,textPane
							@openFile = file
						end
					else
						writeDocument file.getPath,textPane
						@openFile = file
					end	
				rescue IOException
				end
			else
				return false
			end
		else
			puts @openFile.getPath
			puts textPane.getContent
			writeDocument @openFile.getPath,textPane
		end
		return true
	end

	def getCurrentDocument
		if (@openFile != nil)
			return @openFile.getName
		else
			return ""
		end
	end

	##Helper function for opening
	protected
	def readDocument file, textPane
		begin
			fr = FileReader.new file
			reader = BufferedReader.new fr
			line = reader.readLine
			doc = textPane.getStyledDocument
			textPane.clearContent
			while line != nil
				ls = System.getProperty "line.separator"
				textPane.addContent line + ls
				line = reader.readLine
			end

			textPane.resetEdited
		rescue IOException
		end
	end

	##Helper function for saving documents
	protected
	def writeDocument filePath, textPane
		begin
			fw = FileOutputStream.new filePath
			osw = OutputStreamWriter.new fw, "utf-8"
			out = BufferedWriter.new osw
			out.write textPane.getContent

			out.close

			#the text file is no longer dirty!
			textPane.resetEdited
		rescue IOException
		end
	end


end