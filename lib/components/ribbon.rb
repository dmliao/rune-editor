include Java
require '../java/flamingo-6.2.jar'
require '../java/trident.jar'

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

	@fileTasks = nil
	@contentPane = nil #the textpane that the UI will interface with
	@frame = nil #the containing frame
	
	def initialize
		super
		
	end

	def setDependents contentPane, frame
		@contentPane = contentPane
		@frame = frame

		puts "Dependents set"

	end

	def createTasks
		@fileTasks = createFileTasks
		
		self.addTask @fileTasks

		# configureApplicationMenu
	end

	def createIcon filePath, w, h
		imgFile = File.new filePath
		docImg = ImageIO.read imgFile
		dims = Dimension.new w, h
		return ImageWrapperResizableIcon.getIcon docImg, dims
	end

	def createFileTasks

		fileBand = JRibbonBand.new "File", nil

		fileBand.addCommandButton addNewFileButton, RibbonElementPriority::TOP
		fileBand.addCommandButton addOpenFileButton, RibbonElementPriority::TOP
		fileBand.addCommandButton addSaveFileButton, RibbonElementPriority::TOP

		coreResizePolicy = CoreRibbonResizePolicies.getCorePoliciesNone fileBand
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

		clickAction = SaveFileClickAction.new @contentPane, @frame

		saveFileButton.addActionListener clickAction

		return saveFileButton
	end

	def configureApplicationMenu
		begin
			newImgFile = File.new "resources/new.png"
			docNewImg = ImageIO.read newImgFile
			dims = Dimension.new 32,32
			newImgIcon = ImageWrapperResizableIcon.getIcon docNewImg, dims
			entryNew = RibbonApplicationMenuEntryPrimary.new newImgIcon, "Create New Document", nil, JCommandButton::CommandButtonKind::ACTION_ONLY

			applicationMenu = RibbonApplicationMenu.new
			applicationMenu.addMenuEntry entryNew

			self.setApplicationMenu applicationMenu
		rescue IOException
			puts "File not found!"
		end
	end

end

class NewFileClickAction
	include java.awt.event.ActionListener

	@cp = nil
	@f = nil

	def initialize cp, f
		@cp = cp
		@f = f
	end

	def actionPerformed evt
		@frame.createNewDocument @cp, @f
	end
end

class OpenFileClickAction
	include java.awt.event.ActionListener

	@cp = nil
	@f = nil
	def initialize cp, f
		@cp = cp
		@f = f
	end

	def actionPerformed evt
		@frame.openDocument @cp, @f
	end
end
class SaveFileClickAction
	include java.awt.event.ActionListener

	@cp = nil
	@f = nil
	def initialize cp, f
		@cp = cp
		@f = f
	end

	def actionPerformed evt
		@frame.saveDocument false, @cp, @f
	end
end