class FileMenuController < ApplicationController
  require 'file_menu_actions'
  include FileMenuActions

  set_view 'FileMenuView'
end
