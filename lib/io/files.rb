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

#Self-contained module for all file operations
module FilesIO
	@openFile = nil

	module_function
	def openFileName; @openFileName end
	def openFileName= v; @openFileName = v end

	public
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
		else
			handleNewDocument textPane, frame
		end

	end

	protected
	def handleNewDocument textPane, frame
		resetOpenFile
		textPane.clearContent
		textPane.resetEdited
		textPane.resetUndoRedo
	end

	def resetOpenFile
		puts "Resets file"
		@openFile = nil
		FilesIO.openFileName = "Untitled"
		self.updateFooterWCText
	end

	def setOpenFile file
		puts "Opening file"
		FilesIO.openFileName = file.getName
		@openFile = file
		updateFooterWCText
	end

	protected
	def handleOpenDocument textPane, frame
		fileChooser = JFileChooser.new
		returnVal = fileChooser.showOpenDialog frame
		if returnVal == JFileChooser::APPROVE_OPTION
			file = fileChooser.getSelectedFile
			begin
				readDocument file,textPane
				setOpenFile file
				textPane.resetUndoRedo
			end
		else
			return false
		end
		return true
	end

	public
	def openDocument textPane, frame
		if textPane.getEdited == true
			dialogResult = JOptionPane.showConfirmDialog frame, "Do you want to save changes to this document?", "Confirm Open", JOptionPane::YES_NO_OPTION
			if (dialogResult == JOptionPane::YES_OPTION)
				saveDocument false, textPane, frame # Save the document first!
				handleOpenDocument textPane, frame # recursively open another document!
			else	
				handleOpenDocument textPane, frame
			end
		else
			handleOpenDocument textPane, frame
		end
		updateFooterWCText
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
							setOpenFile file
						end
					else
						writeDocument file.getPath,textPane
						setOpenFile file
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

	# Save a new version of the document in the given File object
	def saveNewVersion newFile, textPane, frame

		textPane.updateContent
		if @openFile == nil

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
							setOpenFile file
						end
					else
						writeDocument file.getPath,textPane
						setOpenFile file
					end	
				rescue IOException
				end
			else
				return false
			end
		else
			writeDocument newFile.getPath,textPane
		end
		return true
	end

	# Helper function for opening files
	# Reads the document in the given file, and outputs the result to a textpane
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

	# Helper function for saving documents
	# Writes the text from the textpane into a given file path
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

			textPane.resetUndoRedo
		rescue IOException
		end
	end


end