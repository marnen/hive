class IntroWindowController < ApplicationController
  require 'file_menu_actions'
  require 'file_menu_controller'
  include FileMenuActions

  set_view 'IntroWindowView'
  set_close_action :exit
  
  def initialize
    super
    file_menu = FileMenuController.instance
    add_nested_controller :menus, file_menu
  end
end
