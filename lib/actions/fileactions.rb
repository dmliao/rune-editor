
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
	@saveAs = nil
	def initialize saveAs, cp, f
		@cp = cp
		@f = f
		@saveAs = saveAs
	end

	def actionPerformed evt
		@frame.saveDocument @saveAs, @cp, @f
	end
end
class SaveVersionClickAction
	include java.awt.event.ActionListener

	@cp = nil
	@f = nil
	def initialize cp, f
		@cp = cp
		@f = f
	end

	def actionPerformed evt
		@frame.saveDraft @cp, @f
	end
end