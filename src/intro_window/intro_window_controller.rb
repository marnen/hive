class IntroWindowController < ApplicationController
  set_view 'IntroWindowView'
  set_close_action :exit

  # TODO: Unify file menu methods with DocumentController.
  def file_new_menu_item_action_performed
    instance = DocumentController.create_instance
    instance.open unless instance.nil?
  end

  def file_open_menu_item_action_performed
    instance = DocumentController.create_instance(nil, false)
    instance.open unless instance.nil?
  end

end
