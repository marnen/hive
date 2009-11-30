class IntroWindowController < ApplicationController
  require 'file_menu_controller'

  set_view 'IntroWindowView'
  set_close_action :exit
  
  def initialize
    super
    add_nested_controller :menus, FileMenuController.create_instance
  end
end
