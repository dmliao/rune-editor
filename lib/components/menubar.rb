include Java

require_relative '../actions/fileactions.rb'
require_relative '../actions/uiactions.rb'
require_relative '../actions/windowactions.rb'

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
	@viewMenu = nil

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
		@viewMenu = createViewMenu
		self.add @viewMenu

	end

	protected
	def createMenuItem text, accelerator, actionlistener
		menuItem = JMenuItem.new text
		menuItem.setAccelerator(accelerator)
		menuItem.addActionListener(actionlistener)

		return menuItem
	end

	def createFileMenu
		fileMenu = JMenu.new "File"

		fileMenu.add createMenuItem("New", KeyStroke.getKeyStroke(KeyEvent::VK_N,ActionEvent::CTRL_MASK), NewFileClickAction.new(@contentPane, @frame))
		fileMenu.add createMenuItem("Open", KeyStroke.getKeyStroke(KeyEvent::VK_O,ActionEvent::CTRL_MASK), OpenFileClickAction.new(@contentPane, @frame))
		fileMenu.add createMenuItem("Save", KeyStroke.getKeyStroke(KeyEvent::VK_S,ActionEvent::CTRL_MASK), SaveFileClickAction.new(false,@contentPane, @frame))
		fileMenu.add createMenuItem("Save New Version",KeyStroke.getKeyStroke(KeyEvent::VK_S,ActionEvent::CTRL_MASK+ActionEvent::SHIFT_MASK),SaveVersionClickAction.new(@contentPane, @frame))

		return fileMenu
	end

	def createEditMenu
		editMenu = JMenu.new "Edit"

		editMenu.add createMenuItem("Undo", KeyStroke.getKeyStroke(KeyEvent::VK_Z,ActionEvent::CTRL_MASK), @contentPane.getUndoAction)
		editMenu.add createMenuItem("Redo", KeyStroke.getKeyStroke(KeyEvent::VK_Y,ActionEvent::CTRL_MASK), @contentPane.getRedoAction)

		return editMenu
	end

	def createViewMenu
		viewMenu = JMenu.new "View"

		viewMenu.add createMenuItem("Versions", KeyStroke.getKeyStroke(KeyEvent::VK_V,ActionEvent::CTRL_MASK+ActionEvent::SHIFT_MASK), ShowVersionsAction.new(@frame))

		return viewMenu
	end


end
