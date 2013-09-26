# Module for version controlling
# Part of the files module
include Java


module FilesIO

	private 
	def setVersionDir file
		d = ""
		dir = java.io.File.new file.getPath+".version"
		if (!dir.isDirectory)
			dir.mkdir
		end

		d = dir.getPath

		return d
	end

	public
	def autoSave textPane, frame
		f = @openFile
		if (f == nil)
			puts "Oops."
			return
		end

		dName = setVersionDir f

		autoSaveFile = java.io.File.new dName+"/"+f.getName+".auto"
		saveNewVersion autoSaveFile, textPane, frame
		
	end

	def saveDraft textPane, frame
		f = @openFile
		if (f == nil)
			puts "Oops."
			return
		end

		dName = setVersionDir f

		count = 0
		nextFile = java.io.File.new dName+"/"+f.getName+".draft"+count.to_s

		while (nextFile.isFile)
			count += 1
			nextFile = java.io.File.new dName+"/"+f.getName+".draft"+count.to_s
		end

		saveNewVersion nextFile,textPane,frame
	end

end