require_relative "../actions/textpaneactions.rb"

include Java

import javax.swing.KeyStroke
import java.awt.event.KeyEvent
import javax.swing.JComponent

module FooterUpdater

	@footerAction = nil
	def updateFooterInit
		@footerAction = UpdateFooterWordCountAction.new
		@footerAction.setDependents self,@textPanel

		#Create a keybinder for the textpanel
		condition = JComponent::WHEN_FOCUSED
		iMap = @textPanel.getInputMap condition
		aMap = @textPanel.getActionMap

		String updater = "space"

		iMap.put(KeyStroke.getKeyStroke(KeyEvent::VK_SPACE, 0), updater)
		aMap.put(updater, @footerAction)
	end

end