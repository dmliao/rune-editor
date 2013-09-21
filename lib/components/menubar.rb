include Java

require_relative '../actions/fileactions.rb'

import javax.swing.JMenu
import javax.swing.JMenuItem
import javax.swing.JMenuBar
import javax.swing.KeyStroke
import java.awt.event.KeyEvent
import java.awt.event.ActionEvent
import java.awt.Dimension

# A JMenu for file commands, as an alternative to the ribbon.
# Even if this isn't displayed, it should be added
# as keybindings are attached to this menu bar.
class WriteMenuBar < JMenuBar

	@fileMenu = nil
	@exportMenu = nil
	@editMenu = nil

	@contentPane = nil
	@frame = nil

	def initialize
		super
		setPreferredSize Dimension.new 0,0
	end

	def setDependents contentPane, frame
		@contentPane = contentPane
		@frame = frame
	end

	def createMenu
		@fileMenu = createFileMenu
		self.add @fileMenu
		@editMenu = createEditMenu
		self.add @editMenu

	end

	def createFileMenu
		fileMenu = JMenu.new "File"

		newFileMenuItem = JMenuItem.new "New Document"
		newFileMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_N,ActionEvent::CTRL_MASK))
		newFileMenuItem.addActionListener(NewFileClickAction.new(@contentPane, @frame))

		fileMenu.add newFileMenuItem

		openFileMenuItem = JMenuItem.new "Open Document"
		openFileMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_O,ActionEvent::CTRL_MASK))
		openFileMenuItem.addActionListener(OpenFileClickAction.new(@contentPane, @frame))
		
		fileMenu.add openFileMenuItem

		saveFileMenuItem = JMenuItem.new "Save Document"
		saveFileMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_S,ActionEvent::CTRL_MASK))
		saveFileMenuItem.addActionListener(SaveFileClickAction.new(false,@contentPane, @frame))
		
		fileMenu.add saveFileMenuItem

		return fileMenu
	end

	def createEditMenu
		editMenu = JMenu.new "Edit"

		return editMenu
	end

end
