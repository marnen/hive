class DocumentModel
  require 'data_table_model'
  
  load_gettext
  # Structure holding the actual data.
  attr_accessor :data
  # Name of the associated file.
  attr_reader :filename
  # Is this a new file? (Monkeybars bug 15 workaround.)
  attr_accessor :new_file

  def initialize(filename = nil, new_file = true)
    @new_file = new_file
    if filename
      self.filename = filename
    end
  end

  # Sets the filename, but only if it's nil.
  # This is a workaround for Monkeybars bug 15 (see DocumentController) -- we can remove it when that bug is fixed.
  def filename=(string)
    if filename.nil?
      if string # don't bother if we got passed another nil
        # TODO: Untangle these conditions and remove hard-coded '.h2'.
        @filename = string
        create_file @filename if @new_file
        db = File.join File.expand_path(@filename), 'data'
        @data = DataTableModel.new(db) if (@new_file or File.exists?(db + '.h2'))
      end
      return @filename
    else
      # TODO: choose a type for this exception
      raise "Can't change filename on DocumentModel!"
    end
  end

  # Returns the document title (for example, for window title bar).
  # This will normally be the basename of the associated file.
  def title
    filename.nil? ? nil : File.basename(filename)
  end

  protected

  # Create the document as a directory.
  def create_file(filename)
    # See zipfile branch in repository for zip file creation code.
    Dir.mkdir filename
    # TODO: Handle case where directory can't be created.
  end
end
