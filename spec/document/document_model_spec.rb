require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../src/document/document_model'

describe DocumentModel do
  describe "instance methods" do
    it "should have a title attribute (read/write)" do
      @model = DocumentModel.new
      @model.should respond_to(:title)
      @model.should respond_to(:title=)
    end
  end
end