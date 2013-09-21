require_relative "../lib/components/writearea.rb"
require_relative "../lib/text/undo.rb"
require 'test/unit'

class TestUndo < Test::Unit::TestCase
	def testSingleUndo
		wA = WriteArea.new
		wA.setContent "The moon and the"
		wA.undo
		assert_equal wA.getContent, ""
	end
end