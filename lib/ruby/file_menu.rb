# Mixin to implement standard File menu actions.
module FileMenu
  def file_new_menu_item_action_performed
    instance = DocumentController.create_instance
    instance.open unless instance.nil?
  end

  def file_open_menu_item_action_performed
    instance = DocumentController.create_instance(nil, false)
    instance.open unless instance.nil?
  end
end