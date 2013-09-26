require_relative "config/config.rb"
require_relative "config/fonts.rb"
require_relative "config/textarea.rb"
require_relative "io/files.rb"
require_relative "text/footertext.rb"
require_relative "components/transpanel.rb"
require_relative "components/transparentlabel.rb"
require_relative "components/menubar.rb"
require_relative "components/writearea.rb"
require_relative "components/scrollbar.rb"
require_relative "components/ribbon.rb"


include Java
include Configuration
include FilesIO
include FooterUpdater

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
# This is the program we want to run for now!
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

	@keybindBar = nil

	# Initializes the main frame.
	def initialize
		super "Rune Editor"

		self.initGUI
		self.initProperties
		self.updateConfigs
		self.resetOpenFile
		self.pack
		@textPanel.resetEdited #start out with a blank textpane

		# FIXME: Hack to get word count to update all the time
		# Find a way to do better!
		Thread.new do
			while true do
				self.updateFooterWCText
				sleep 2
			end
		end

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

		@keybindBar = WriteMenuBar.new
		@keybindBar.setDependents @textPanel, self
		@keybindBar.createMenu
		self.setJMenuBar @keybindBar

		self.updateFooterInit # bind word count events!

	end

	# sets the look and feel of the app. All other global look and feel rules go here.
	protected
	def setLookAndFeel
		UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName())
		
	end

	public
	def getCurrentDocument
		return FilesIO.openFileName
	end

	protected
	def createHeaderPanel
		headerPanel = JPanel.new
		headerPanel.setOpaque false
		return headerPanel
	end

	protected
	def createFooterPanel
		footerPanel = TranslucentPanel.new
		
		@footerText = TransparentLabel.new "Footer Text Here!"
		@footerText.setOpaque false

		footerPanel.setBorder EmptyBorder.new 0, 0, 0, 0
		footerPanel.setBackground Color.new 0,0,0,0
		footerPanel.add @footerText

		@footerText.setBackground Color.new 0,0,0,0

		return footerPanel
	end

	# Updates the footer text. Used to provide extra information in the footer.
	# +footerText+ - the text that should be displayed in the footer.
	public
	def updateFooterPanel footerText
		@footerText.setText footerText
	end

	def getFooterPanel
		return @footerPanel
	end

	def getFooterLabel
		return @footerText
	end

	# Function to get the current footer text
	# +return+ - String, the footer text
	def getFooterText
		return @footerText.getText
	end

	protected
	def createMainPanel
		mainPanel = JPanel.new
		box = BoxLayout.new mainPanel,BoxLayout::PAGE_AXIS
		mainPanel.setLayout box

		return mainPanel
	end

	public
	def getMainPanel
		return @mainPanel
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


	# Method to update the entire app based on the configurations file
	public
	def updateConfigs
		updateTextBoxFont @textPanel
		updateTextAreaBoundaries @textPanel, @headerPanel, @footerPanel
		updateTextAreaColor @page
		updateTextAreaColor @scrollPanel
		updateTextAreaColor @textPanel
		updateTextAreaColor @scrollPanel.getVerticalScrollBar
	end

	def updateFooterWCText
		updateFooterPanel(getCurrentDocument + " | Word Count: " + @textPanel.getCount.to_s)
		# Hack to get everything to avoid having artifacts...not the best solution, but it works for now.
		# FIXME: Find a more efficient solution to avoid ghosting images on text update!
		self.repaint
	end

end

##UNIT TESTING
App.new