require_relative "config/config.rb"
require_relative "config/fonts.rb"
require_relative "config/textarea.rb"
require_relative "io/files.rb"
require_relative "components/writearea.rb"
require_relative "components/scrollbar.rb"
require_relative "components/ribbon.rb"

include Java
include Configuration
include FilesIO

import java.awt.Dimension
import java.awt.Color

import javax.swing.JFrame
import javax.swing.JPanel
import javax.swing.JLabel
import javax.swing.JScrollPane
import javax.swing.JTextArea
import javax.swing.UIManager
import javax.swing.BoxLayout

import javax.swing.Box

import java.awt.BorderLayout

import javax.swing.border.EmptyBorder

# The main frame for the program, that holds all of the other components
class App < JFrame

	@mainPanel = nil
	@page = nil
	@textPanel = nil
	@scrollPanel = nil
	@headerPanel = nil
	@footerPanel = nil
	@boxLayout = nil

	@ribbon = nil

	@footerText = nil

	def initialize
		super "Rune Desktop Writer"

		self.initGUI
		self.initProperties
		self.updateConfigs

		self.pack

		self.updateFooterPanel self.getCurrentDocument
	end

	# Initializes the GUI and layout of the entire application.
	# Called when the program is initialized.
	protected
	def initGUI
		self.setLookAndFeel
		self.setPreferredSize Dimension.new 640, 480

		@headerPanel = createHeaderPanel
		@footerPanel = createFooterPanel
		@mainPanel = createMainPanel

		@textPanel = createTextPane
		@scrollPanel = createScrollPanel @textPanel

		@page = createPage @textPanel, @scrollPanel
		
		@mainPanel.add @page
		self.add @mainPanel, BorderLayout::CENTER

		@ribbon = ToolbarRibbon.new
		@ribbon.setDependents @textPanel, self
		@ribbon.createTasks
		self.add @ribbon, BorderLayout::NORTH

		self.setVisible true
		@textPanel.resetEdited

	end

	def setLookAndFeel
		# UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName())
		
	end

	protected
	def createHeaderPanel
		headerPanel = JPanel.new
		headerPanel.setOpaque false
		return headerPanel
	end

	protected
	def createFooterPanel
		footerPanel = JPanel.new
		footerPanel.setOpaque false
		
		@footerText = JLabel.new "Footer Text Here!"
		footerPanel.setBorder EmptyBorder.new 0, 0, 0, 0
		footerPanel.add @footerText

		return footerPanel
	end

	def updateFooterPanel footerText
		@footerText.setText footerText
	end

	protected
	def createMainPanel
		mainPanel = JPanel.new
		box = BoxLayout.new mainPanel,BoxLayout::PAGE_AXIS
		mainPanel.setLayout box

		return mainPanel
	end

	protected
	def createPage textPanel, scrollPanel

		page = JPanel.new BorderLayout.new
		page.add @headerPanel, BorderLayout::NORTH
		page.add @scrollPanel, BorderLayout::CENTER
		page.add @footerPanel, BorderLayout::SOUTH

		page.setMaximumSize Dimension.new 960,10000

		return page
		
	end

	protected
	def createScrollPanel textPanel
		scrollPanel = RuneScrollPane.new textPanel
		scrollPanel.setBorder nil
		scrollPanel.setOpaque false
		
		return scrollPanel
	end

	protected
	def createTextPane
		textPanel = WriteArea.new
		textPanel.setOpaque false
		textPanel.setBorder nil
		
		return textPanel
	end


	def updateConfigs
		updateTextBoxFont @textPanel
		updateTextAreaBoundaries @textPanel, @headerPanel, @footerPanel
		updateTextAreaColor @page
		updateTextAreaColor @scrollPanel
		updateTextAreaColor @textPanel
		updateTextAreaColor @scrollPanel.getVerticalScrollBar
	end

end

##UNIT TESTING
App.new