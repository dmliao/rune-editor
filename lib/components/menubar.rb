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
		# setPreferredSize Dimension.new 0,0
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

	protected
	def createNewMenuItem
		fileMenuItem = JMenuItem.new "New Document"
		fileMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_N,ActionEvent::CTRL_MASK))
		fileMenuItem.addActionListener(NewFileClickAction.new(@contentPane, @frame))

		return fileMenuItem
	end

	protected
	def createOpenMenuItem
		fileMenuItem = JMenuItem.new "Open Document"
		fileMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_O,ActionEvent::CTRL_MASK))
		fileMenuItem.addActionListener(OpenFileClickAction.new(@contentPane, @frame))

		return fileMenuItem
	end

	protected
	def createSaveMenuItem
		fileMenuItem = JMenuItem.new "Save Document"
		fileMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_S,ActionEvent::CTRL_MASK))
		fileMenuItem.addActionListener(SaveFileClickAction.new(false,@contentPane, @frame))

		return fileMenuItem
	end

	protected
	def createVersionMenuItem
		fileMenuItem = JMenuItem.new "Save New Version"
		fileMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_S,ActionEvent::CTRL_MASK+ActionEvent::SHIFT_MASK))
		fileMenuItem.addActionListener(SaveVersionClickAction.new(@contentPane, @frame))

		return fileMenuItem
	end

	def createFileMenu
		fileMenu = JMenu.new "File"

		fileMenu.add createNewMenuItem
		fileMenu.add createOpenMenuItem
		fileMenu.add createSaveMenuItem
		fileMenu.add createVersionMenuItem

		return fileMenu
	end

	def createEditMenu
		editMenu = JMenu.new "Edit"

		undoMenuItem = JMenuItem.new "Undo"
		undoMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_Z,ActionEvent::CTRL_MASK))
		undoMenuItem.addActionListener(@contentPane.getUndoAction)

		editMenu.add undoMenuItem

		redoMenuItem = JMenuItem.new "Redo"
		redoMenuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent::VK_Y,ActionEvent::CTRL_MASK))
		redoMenuItem.addActionListener(@contentPane.getRedoAction)

		editMenu.add redoMenuItem

		return editMenu
	end

end
