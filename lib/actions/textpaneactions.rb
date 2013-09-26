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
		
	end

end