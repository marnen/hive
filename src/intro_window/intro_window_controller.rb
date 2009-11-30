class IntroWindowController < ApplicationController
  require 'file_menu'
  include FileMenu

  set_view 'IntroWindowView'
  set_close_action :exit
end
