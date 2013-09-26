class HideShowComponentAction
	include java.awt.event.ActionListener

	@c = nil
	@f = nil

	def initialize c, f
		@c = c
		@f = f
	end

	def actionPerformed evt
		@c.setVisible !@c.isVisible
		@f.repaint

	end
end
