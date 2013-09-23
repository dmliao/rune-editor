# Undo and redo actions for the menubar
# Requires a textpane with the undoredo module attached.
# Yay!

import javax.swing.Action
import javax.swing.AbstractAction


class UndoAction < AbstractAction
	@undoManager = nil
	@undoAction = nil
	@redoAction = nil

	def initialize
		
	end

	def setManagers u, uA, rA
		@undoManager = u
		@undoAction = uA
		@redoAction = rA

		putValue(Action::NAME, @undoManager.getUndoPresentationName)
		setEnabled false
	end

	def actionPerformed e
		if isEnabled
			@undoManager.undo
			@undoAction.update
			@redoAction.update
		end
	end

	def update
		putValue(Action::NAME, @undoManager.getUndoPresentationName)
		setEnabled @undoManager.canUndo
	end
end

class RedoAction < AbstractAction
	@undoManager = nil
	@undoAction = nil
	@redoAction = nil

	def initialize
		
	end

	def setManagers u, uA, rA
		@undoManager = u
		@undoAction = uA
		@redoAction = rA

		putValue(Action::NAME, @undoManager.getRedoPresentationName)
		setEnabled false
	end

	def actionPerformed e
		if isEnabled
			@undoManager.redo
			@undoAction.update
			@redoAction.update
		end
	end

	def update
		putValue(Action::NAME, @undoManager.getRedoPresentationName)
		setEnabled @undoManager.canRedo
	end
end