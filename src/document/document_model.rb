class DocumentModel
  load_gettext
  attr_accessor :title

  def initialize
    @title = _('Document-%{num}') % {:num => 1}
  end
end
