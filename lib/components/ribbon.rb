include Java
require_relative '../../java/flamingo-6.2.jar'
require_relative '../../java/trident.jar'
require_relative '../actions/fileactions.rb'

import org.pushingpixels.flamingo.api.ribbon.JRibbon
import org.pushingpixels.flamingo.api.ribbon.JRibbonBand
import org.pushingpixels.flamingo.api.common.JCommandButton
import org.pushingpixels.flamingo.api.ribbon.RibbonTask
import org.pushingpixels.flamingo.api.ribbon.resize.IconRibbonBandResizePolicy
import org.pushingpixels.flamingo.api.ribbon.RibbonElementPriority
import org.pushingpixels.flamingo.api.ribbon.resize.CoreRibbonResizePolicies
import java.util.Arrays
import java.util.Collections
import java.util.ArrayList
import java.awt.Dimension
import java.io.File
import javax.imageio.ImageIO
import org.pushingpixels.flamingo.api.common.icon.ImageWrapperResizableIcon
import org.pushingpixels.flamingo.api.ribbon.RibbonApplicationMenuEntryPrimary
import org.pushingpixels.flamingo.api.ribbon.RibbonApplicationMenu

class ToolbarRibbon < JRibbon

	@fileTasks = nil # taskbar with all file functions
	@contentPane = nil # the textpane that the UI will interface with
	@frame = nil # the containing frame
	
	def initialize
		super
		
	end

	def setDependents contentPane, frame
		@contentPane = contentPane
		@frame = frame
	end

	def createTasks
		@fileTasks = createFileTasks
		
		self.addTask @fileTasks
	end

	def createIcon filePath, w, h
		imgFile = File.new(__FILE__ + '/../../' + filePath)
		docImg = ImageIO.read imgFile
		dims = Dimension.new w, h
		return ImageWrapperResizableIcon.getIcon docImg, dims
	end

	def createFileTasks

		fileBand = JRibbonBand.new "File", nil

		fileBand.addCommandButton addNewFileButton, RibbonElementPriority::TOP
		fileBand.addCommandButton addOpenFileButton, RibbonElementPriority::TOP
		fileBand.addCommandButton addSaveFileButton, RibbonElementPriority::TOP
		
		coreResizePolicy = CoreRibbonResizePolicies.getCorePoliciesRestrictive fileBand
		irbrList = ArrayList.new

		irbrList.addAll coreResizePolicy

		irbrList.remove irbrList.size-1

		irbr = IconRibbonBandResizePolicy.new fileBand.getControlPanel
		irbrList.add irbr

		puts irbrList
		
		#coreResizePolicy.addAll irbrList
		fileBand.setResizePolicies irbrList

		fileTasks = RibbonTask.new "Home", fileBand


		return fileTasks
	end

	def addNewFileButton
		newImgIcon = createIcon "resources/new.png", 32, 32
		newFileButton = JCommandButton.new "New", newImgIcon

		clickAction = NewFileClickAction.new @contentPane, @frame

		newFileButton.addActionListener clickAction
		
		return newFileButton
	end

	def addOpenFileButton
		openImgIcon = createIcon "resources/open.png", 32, 32
		openFileButton = JCommandButton.new "Open", openImgIcon

		clickAction = OpenFileClickAction.new @contentPane, @frame

		openFileButton.addActionListener clickAction

		return openFileButton
	end
	def addSaveFileButton
		saveImgIcon = createIcon "resources/save.png", 32, 32
		saveFileButton = JCommandButton.new "Save", saveImgIcon

		clickAction = SaveFileClickAction.new false, @contentPane, @frame

		saveFileButton.addActionListener clickAction

		return saveFileButton
	end

	def addSaveAsFileButton
		saveAsImgIcon = createIcon "resources/save.png", 32, 32
		saveAsFileButton = JCommandButton.new "Save As", saveAsImgIcon

		clickAction = SaveFileClickAction.new true, @contentPane, @frame

		saveAsFileButton.addActionListener clickAction

		return saveAsFileButton
	end
end
