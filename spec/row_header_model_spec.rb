require File.dirname(__FILE__) + '/spec_helper'
require 'row_header_model'

describe RowHeaderModel do
  describe "general properties" do
    it "should implement the Java TableModel interface" do
      RowHeaderModel.included_modules.should include(javax.swing.table.TableModel)
    end
  end

  describe "constructor/row_count" do
    it "should take an integer and return a table with that number of rows" do
      RowHeaderModel.new(15).row_count.should == 15
    end

    it "should return a table with 0 rows if called without an argument" do
      RowHeaderModel.new.row_count.should == 0
    end
  end

  describe "instance methods" do
    before :each do
      @model = RowHeaderModel.new(20)
    end

    describe "column_count" do
      it "should always equal 1" do
        @model.column_count.should == 1
      end

      it "should also be accessible as getColumnCount" do
        @model.getColumnCount.should == @model.column_count
      end
    end

    describe "table" do
      it "should be valid" do
        @model.should respond_to(:table)
      end

      it "should return a JTable" do
        @model.table.should be_a_kind_of(javax.swing.JTable)
      end

      it "should use the RowHeaderModel as its model" do
        @model.table.model.should == @model
      end

      it "should use a header-style renderer for numbers" do
        @model.table.get_default_renderer(java.lang.Number).java_class.should == javax.swing.table.JTableHeader.new.default_renderer.java_class
      end

      it "should set its viewport size" do
        @model.table.preferred_scrollable_viewport_size.should == @model.table.preferred_size
      end
   end

    describe "value_at" do
      it "should be valid" do
        @model.should respond_to(:value_at)
      end
      
      it "should return the row number (1-based)" do
        @model.row_count.times do |i|
          @model.value_at(i, 0).should == i + 1
        end
      end

      it "should be aliased as getValueAt" do
        @model.method(:getValueAt).should == @model.method(:value_at)
      end
    end

    describe "cell_editable?" do
      it "should be valid" do
        @model.should respond_to(:cell_editable?)
      end

      it "should always return false" do
        @model.row_count.times do |i|
          @model.cell_editable?(i, 0).should be_false
        end
      end

      it "should be aliased as isCellEditable" do
        @model.method(:isCellEditable).should == @model.method(:cell_editable?)
      end
    end

    describe "column_class" do
      it "should be valid" do
        @model.should respond_to(:column_class)
      end

      it "should return Number for column 0" do
        @model.column_class(0).should == java.lang.Number
      end

      it "should be accessible as getColumnClass" do
        @model.getColumnClass(0).should == @model.column_class(0)
      end
    end
  end
end