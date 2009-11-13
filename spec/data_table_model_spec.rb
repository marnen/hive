require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../../src/data_table_model'

describe DataTableModel do
  describe "general properties" do
    it "should implement the Java TableModel interface" do
      DataTableModel.included_modules.should include(javax.swing.table.TableModel)
    end
  end

  describe "constructor" do
    it "should give a new table one column" do
      DataTableModel.new.column_count.should == 1
    end
  end

  describe "Java integration" do
    before :each do
      @model = DataTableModel.new
    end

    it "should treat Java getter names like Ruby getters" do
      @model.should respond_to(:getColumnCount)
      @model.getColumnCount.should == @model.column_count
    end
  end
end
