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