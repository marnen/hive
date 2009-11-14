require File.dirname(__FILE__) + '/spec_helper'
require 'data_table_model'

describe DataTableModel do
  describe "general properties" do
    it "should implement the Java TableModel interface" do
      DataTableModel.included_modules.should include(javax.swing.table.TableModel)
    end
  end

  describe "constructor" do
    it "should give a new table two columns" do
      DataTableModel.new.column_count.should == 2
    end
  end

  describe "instance methods" do
    before :each do
      @model = DataTableModel.new
    end

    describe "row_header_view" do
      it "should be valid" do
        @model.should respond_to(:row_header_view)
      end

      it "should return a JTable" do
        @model.row_header_view.should be_a_kind_of(javax.swing.JTable)
      end

      it "should have the same number of rows as this table" do
        @model.row_header_view.row_count.should == @model.row_count
      end

      it "should use a header-style renderer for numbers" do
        @model.row_header_view.get_default_renderer(java.lang.Number).java_class.should == javax.swing.table.JTableHeader.new.default_renderer.java_class
      end
    end

    describe "set_value_at" do
      it "should be valid" do
        @model.should respond_to(:set_value_at)
      end

      it "should return the value when the cell reference is legitimate" do
        @model.set_value_at("value", @model.row_count - 1, @model.column_count - 1).should == "value"
      end

      it "should raise an exception (and not set the value) when the cell reference is not legitimate" do
        lambda{@model.set_value_at("value", @model.row_count, @model.column_count)}.should raise_error(IndexError)
        begin
          @model.get_value_at(@model.row_count, @model.column_count).should_not == "value"
        rescue NativeException
          # ignore exceptions
        end
      end

      it "should be available as setValueAt" do
        @model.setValueAt("value", @model.row_count - 1, @model.column_count - 1).should == "value"
      end
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
