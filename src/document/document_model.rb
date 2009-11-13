class DocumentModel
  require 'data_table_model'
  
  load_gettext
  # Window title.
  attr_accessor :title
  # Structure holding the actual data.
  attr_accessor :data

  def initialize
    set_title_with_number 1
    @data = DataTableModel.new
  end

  def count=(number)
    set_title_with_number number
  end

  protected

  def set_title_with_number(number)
    @title = _('Document-%{num}') % {:num => number}
  end
end
