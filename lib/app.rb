require "config/config.rb"
require "config/fonts.rb"
require "config/textarea.rb"
require "io/files.rb"
require "components/writearea.rb"
require "components/scrollbar.rb"
require "components/ribbon.rb"

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

	def createHeaderPanel
		headerPanel = JPanel.new
		headerPanel.setOpaque false
		return headerPanel
	end

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

	def createMainPanel
		mainPanel = JPanel.new
		box = BoxLayout.new mainPanel,BoxLayout::PAGE_AXIS
		mainPanel.setLayout box

		return mainPanel
	end

	def createPage textPanel, scrollPanel

		page = JPanel.new BorderLayout.new
		page.add @headerPanel, BorderLayout::NORTH
		page.add @scrollPanel, BorderLayout::CENTER
		page.add @footerPanel, BorderLayout::SOUTH

		page.setMaximumSize Dimension.new 960,10000

		return page
		
	end


	def createScrollPanel textPanel
		scrollPanel = RuneScrollPane.new textPanel
		scrollPanel.setBorder nil
		scrollPanel.setOpaque false
		
		return scrollPanel
	end

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