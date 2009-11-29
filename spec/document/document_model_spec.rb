require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../src/document/document_model'
require 'tmpdir'

describe DocumentModel do
  before :each do
    @tmpdir = Dir.mktmpdir 'DocumentModel'
  end

  describe "constructor" do
    it "should set the data object to a kind of TableModel" do
      @model = DocumentModel.new File.join(@tmpdir, 'constructor')
      @model.data.class.included_modules.should include(javax.swing.table.TableModel)
    end

    it "should have a zero-argument form" do
      lambda {DocumentModel.new}.should_not raise_error(ArgumentError)
    end

    it "should take a filename as argument" do
      lambda {DocumentModel.new File.join(@tmpdir, 'foo')}.should_not raise_error(ArgumentError)
    end

    it "should create a new folder with the specified filename, if new_file is true or unspecified" do
      [['filename without new_file'], ['filename with new_file', true]].each do |args|
        filename = args[0] = File.join(@tmpdir, args[0])
        File.should_not exist(filename)
        DocumentModel.new *args
        File.should exist(filename)
        File.stat(filename).should be_directory
      end
    end

    it "should not create a new folder if new_file is false" do
      filename = File.join(@tmpdir, 'this file should not be created')
      File.should_not exist(filename)
      DocumentModel.new filename, false
      File.should_not exist(filename)
    end

    it "should put an H2 database into the folder it creates" do
      pending "Does this really need to happen at creation time? \
It's probably OK if the DB springs into existence when the first table is added." do
        filename = File.join(@tmpdir, 'test file')
        @model = DocumentModel.new filename
        Dir[File.join filename, '*.h2.db'].should_not be_empty
      end
    end
  end

  describe "instance methods" do
    before :each do
      @model = DocumentModel.new
    end

    it "should have a data attribute (read/write)" do
      @model.should respond_to(:data)
      @model.should respond_to(:data=)
    end

    it "should have a new_file attribute (read/write)" do
      @model.should respond_to(:new_file)
      @model.should respond_to(:new_file=)
    end

    describe "filename" do
      it "should be valid for reading and writing" do
        @model.should respond_to(:filename)
        @model.should respond_to(:filename=)
      end

      it "should raise an error if an existing filename is changed" do
        filename = File.join @tmpdir, 'foo'
        @model.filename.should be_nil
        @model.filename = filename
        @model.filename.should == filename
        lambda {@model.filename = File.join @tmpdir, 'bar'}.should raise_error
      end

      it "should not raise an error if filename is changed from nil to nil" do
        @model.filename.should be_nil
        lambda {@model.filename = nil}.should_not raise_error
        @model.filename.should be_nil
      end
    end

    describe "title" do
      it "should be valid" do
        @model.should respond_to(:title)
      end

      it "should return the basename of the filename" do
        name = 'an arbitrary filename'
        subdirectory = 'an arbitrary subdirectory'
        Dir.mkdir File.join(@tmpdir, subdirectory)
        @model.filename = File.join @tmpdir, subdirectory, name
        @model.title.should == name
      end

      it "should return nil if the filename is nil" do
        @model.title.should be_nil
      end
    end
  end
  
  after :each do
    FileUtils.rm_r @tmpdir
  end
end