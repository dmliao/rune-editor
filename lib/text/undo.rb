# Self-contained undo and redo module.
# Attach this module to a WriteArea.
module UndoRedo
	
	@undoThreshold = 32 # the number of times we can undo

	def setUndoThreshold threshold
		@undoThreshold = threshold
	end

	def getUndoThreshold
		return @undoThreshold
	end

	# Undo method
	# Undoes a single step in the textPane, and can stack
	# Does nothing if we've undone past the threshold
	def undo
	end

	# Redo method
	# Redoes a single step in the textPane, and can stack
	# Does nothing if we've redone to the last step
	def redo
	end

end