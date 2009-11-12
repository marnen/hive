class DocumentModel
  load_gettext
  attr_accessor :title

  def initialize
    set_title_with_number 1
  end

  def count=(number)
    set_title_with_number number
  end

  protected

  def set_title_with_number(number)
    @title = _('Document-%{num}') % {:num => number}
  end
end
