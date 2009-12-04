require File.dirname(__FILE__) + '/spec_helper'
require 'data_table_model'
require 'tmpdir'

describe DataTableModel do
  before :each do
    @tmpdir = Dir.mktmpdir 'DataTableModel'
  end

  describe "general properties" do
    it "should implement the Java TableModel interface" do
      DataTableModel.included_modules.should include(javax.swing.table.TableModel)
    end
  end

  describe "constructor" do
    it "should connect to the supplied database" do
      filename = File.join @tmpdir, 'Database connection'
      connection_string = "jdbc:h2:file:#{filename}"
      db = Sequel.connect connection_string
      Sequel.should_receive(:connect).with(connection_string).and_return db
      DataTableModel.new filename
    end

    it "should give a new table two columns" do
      DataTableModel.new(File.join @tmpdir, 'Columns').column_count.should == 2
    end

    it "should not try to create a data table that already exists" do
      filename = File.join @tmpdir, 'Duplicate table'
      DataTableModel.new filename
      lambda {DataTableModel.new filename}.should_not raise_error
    end
  end

  describe "instance methods" do
    before :each do
      @model = DataTableModel.new File.join(@tmpdir, 'Instance methods')
    end

    describe "row_header" do
      it "should be valid" do
        @model.should respond_to(:row_header)
      end

      it "should return a JViewport" do
        @model.row_header.should be_a_kind_of(javax.swing.JViewport)
      end

      it "should have row_header_view as its view" do
        # Doing it this way because a simple equality test doesn't quite work.  Yuck.
        vp = mock('JViewport', :null_object => true)
        table = mock('JTable')
        @model.stub!(:row_header_view).and_return table
        vp.should_receive(:view=).with(table)
        javax.swing.JViewport.stub!(:new).and_return vp
        @model.row_header
      end

      it "should have a change listener" do
        vp = mock('JViewport', :null_object => true)
        vp.should_receive(:add_change_listener).and_return true
        javax.swing.JViewport.stub!(:new).and_return vp
        @model.row_header
      end
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

    describe "setting and getting values" do
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

      describe "value_at" do
        it "should return the value when the cell reference is legitimate" do
          r = @model.row_count - 1
          c = @model.column_count - 1
          @model.value_at(r, c).should == "R#{r + 1}, C#{c + 1}"
        end

        it "should raise an exception  when the cell reference is not legitimate" do
          lambda{@model.value_at(@model.row_count, @model.column_count)}.should raise_error(IndexError)
        end

        it "should be available as getValueAt" do
         r = @model.row_count - 1
         c = @model.column_count - 1
         @model.getValueAt(r, c).should == @model.value_at(r, c)
        end
      end
      
      it "should be able to retrieve the values it sets" do
        row = 5 # arbitrary
        col = 1 # arbitrary
        value = "some arbitrary value"
        @model.set_value_at(value, row, col)
        @model.value_at(row, col).should == value
      end
    end
  end

  describe "Java integration" do
    before :each do
      @model = DataTableModel.new File.join(@tmpdir, 'Java integration')
    end

    it "should treat Java getter names like Ruby getters" do
      @model.should respond_to(:getColumnCount)
      @model.getColumnCount.should == @model.column_count
    end
  end

  after :each do
    FileUtils.rm_r @tmpdir
  end
end
