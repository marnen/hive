require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../src/document/document_model'

describe DocumentModel do
  describe "constructor" do
   before :each do
     @model = DocumentModel.new
   end

    it "should set the title" do
      @model.title.should_not be_nil
    end

    it "should set the data object to a kind of TableModel" do
      @model.data.class.included_modules.should include(javax.swing.table.TableModel)
    end
  end
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

    it "should have a data attribute (read/write)" do
      @model.should respond_to(:data)
      @model.should respond_to(:data=)
    end
  end
end