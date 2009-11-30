class IntroWindowView < ApplicationView
  set_java_class 'intro_window.IntroWindow'
  nest :view => :menu_bar, :sub_view => :menus
end
