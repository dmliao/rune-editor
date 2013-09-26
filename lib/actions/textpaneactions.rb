include Java

import javax.swing.Action
import javax.swing.AbstractAction

class UpdateFooterWordCountAction < AbstractAction

	@frame = nil
	@textPane = nil

	def setDependents frame, textPane
		@frame = frame
		@textPane = textPane
	end

	def actionPerformed evt
		puts @textPane.getCount
		@frame.updateFooterWCText
		# Hack to get everything to avoid having artifacts...not the best solution, but it works for now.
		# FIXME: Find a more efficient solution to avoid ghosting images on text update!
		@frame.repaint
	end

end