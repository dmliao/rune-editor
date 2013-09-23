include Java

require_relative "../actions/undoactions.rb"
import javax.swing.undo.UndoManager

# Self-contained undo and redo module.
# Attach this module to a WriteArea.
module UndoRedo
	
	@undoManager = nil

	@undoAction = nil
	@redoAction = nil

	def initUndoRedo textPane
		@undoManager = UndoManager.new
		@undoAction = UndoAction.new
		@redoAction = RedoAction.new

		uListener = UndoListener.new
		uListener.getActions @undoManager, @undoAction, @redoAction

		@undoAction.setManagers @undoManager, @undoAction, @redoAction
		@redoAction.setManagers @undoManager, @undoAction, @redoAction

		textPane.getDocument.addUndoableEditListener uListener
	end

	def resetUndoRedo
		@undoManager.discardAllEdits
	end

	# Undo method
	# Undoes a single step in the textPane, and can stack
	# Does nothing if we've undone past the threshold
	def getUndoAction
		return @undoAction
	end

	# Redo method
	# Redoes a single step in the textPane, and can stack
	# Does nothing if we've redone to the last step
	def getRedoAction
		return @redoAction
	end

	class UndoListener 
		include javax.swing.event.UndoableEditListener

		@undoManager = nil
		@undoAction = nil
		@redoAction = nil

		def getActions undoManager, undoAction, redoAction
			@undoManager = undoManager
			@undoAction = undoAction
			@redoAction = redoAction
		end

		def undoableEditHappened e
			@undoManager.addEdit e.getEdit
			@undoAction.update
			@redoAction.update
		end
	end

	
			
end

