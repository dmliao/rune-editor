include Java
require_relative '../../java/swt.jar'

import org.eclipse.swt.widgets.Display
import org.eclipse.swt.widgets.Shell
import org.eclipse.swt.SWT
import org.eclipse.swt.widgets.FileDialog


class SWTOpenDialog
	@return
	def initialize
		display = Display.new
		shell = Shell.new display

		dialog = FileDialog.new(shell, SWT::OPEN | SWT::MULTI)
		dialog.open
		if (dialog.getFileName == "")
			@return = nil
		else
			@return = java.io.File.new dialog.getFilterPath, dialog.getFileName
		end
		shell.close
		while (!shell.isDisposed)
			if (!display.readAndDispatch)
				display.sleep
			end
		end
		display.dispose
	end

	def getFile
		return @return
	end
end


class SWTSaveDialog
	@return
	def initialize
		display = Display.new
		shell = Shell.new display

		dialog = FileDialog.new(shell, SWT::SAVE | SWT::MULTI)
		dialog.open
		if (dialog.getFileName == "")
			@return = nil
		else
			@return = java.io.File.new dialog.getFilterPath, dialog.getFileName
		end
		shell.close
		while (!shell.isDisposed)
			if (!display.readAndDispatch)
				display.sleep
			end
		end
		display.dispose
	end

	def getFile
		return @return
	end
end
