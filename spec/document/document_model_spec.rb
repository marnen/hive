require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../src/document/document_model'

describe DocumentModel do
  describe "instance methods" do
    before :each do
      @model = DocumentModel.new
    end

    it "should have a title attribute (read/write)" do
      @model.should respond_to(:title)
      @model.should respond_to(:title=)
    end

    it "should have a count writer" do
      @model.should respond_to(:count=)
    end

    it "should incorporate the count in the title" do
      @model.title.should == 'Document-1'
      @model.count = 25
      @model.title.should == 'Document-25'
    end
  end
end