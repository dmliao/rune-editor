class ShowVersionsAction
	include java.awt.event.ActionListener
	@frame = nil

	def initialize frame
		@frame = frame
	end
	def actionPerformed e
		@frame.createVersionDialog
	end

end
