# Creates a window to compare versions!

include Java

import javax.swing.JDialog
import javax.swing.JPanel
import javax.swing.JLabel
import javax.swing.JScrollPane
import javax.swing.JTextArea
import java.awt.GridLayout
import java.io.BufferedReader
import java.io.FileReader
import java.io.BufferedWriter
import java.io.FileWriter
import java.io.OutputStreamWriter
import java.io.FileOutputStream
import java.lang.System
import java.awt.Dimension
import java.awt.Color

import java.awt.BorderLayout
import java.awt.Component;
import javax.swing.BoxLayout


class VersionDialog < JDialog

	@frame = nil
	def initialize frame
		super
		@frame = frame

		initGUI

		self.pack
	end
	def initGUI
		backPanel = JPanel.new

		backPanel.setLayout(BoxLayout.new(backPanel,BoxLayout::X_AXIS))
	
		scrollPanel = JScrollPane.new backPanel
		scrollPanel.setPreferredSize Dimension.new 640,480

		self.add scrollPanel

		if (FilesIO.openFile != nil)

			versionDir = java.io.File.new FilesIO.openFile.getPath+".version"

			if (versionDir.exists == false)
				# No versions D:
				setEmptyPane backPanel
			else
				for fileEntry in versionDir.listFiles
					if (!fileEntry.isDirectory)
						# Add to the scrollpane!
						versionPanel = JPanel.new 
						versionPanel.setLayout BorderLayout.new

						tArea = JTextArea.new 120,50
						tArea.setEditable false
						readVersion fileEntry,tArea

						versionPanel.add tArea,BorderLayout::CENTER
						versionPanel.setPreferredSize(Dimension.new(tArea.getPreferredSize.width+24,tArea.getPreferredSize.height+80))
					
						versionPanel.setAlignmentY(Component::TOP_ALIGNMENT)
						versionPanel.setBackground Color::blue
						backPanel.add versionPanel

					end
				end
			end
		else
			setEmptyPane backPanel
		end

		setDefaultCloseOperation(DISPOSE_ON_CLOSE)
	end

	# Helper function to populate the panel when no versions of the file exist
	def setEmptyPane backPanel

	end

	# Helper function for opening files
	# Reads the document in the given file, and outputs the result to a textpane
	protected
	def readVersion file, textArea
		begin
			fr = FileReader.new file
			reader = BufferedReader.new fr
			line = reader.readLine
			textArea.setText ""
			count = 0
			while line != nil
				ls = System.getProperty "line.separator"
				textArea.append line + ls
				line = reader.readLine
				count += 1
			end
			textArea.setRows(count+1)
		rescue IOException
		end
	end


end