# Mixin to implement standard File menu actions.
module FileMenu
  def file_new_menu_item_action_performed
    new_document
  end

  def file_open_menu_item_action_performed
    open_document
  end

  private

  def new_document
    get_document
  end

  def open_document
    get_document(nil, false)
  end

  def get_document(*args)
    instance = DocumentController.create_instance(*args)
    instance.open unless instance.nil?
  end
end