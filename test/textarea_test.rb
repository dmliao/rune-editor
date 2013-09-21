require_relative "../lib/components/writearea.rb"
require 'test/unit'

class TestText < Test::Unit::TestCase
	def testTextInit
		wA = WriteArea.new
		c = wA.getContent
		assert_equal c, ""
	end

	def testTextNew
		wA = WriteArea.new
		assert_equal wA.getEdited, false
	end

	def testFileAddContent
		wA = WriteArea.new
		wA.setContent "The moon"
		wA.addContent " and the cheese"
		assert_equal wA.getContent, "The moon and the cheese"
	end

	def testFileClearContent
		wA = WriteArea.new
		wA.setContent "The moon"
		wA.addContent " and the cheese"
		wA.clearContent
		assert_equal wA.getContent, ""
	end

end