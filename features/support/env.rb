path = File.expand_path(File.dirname(__FILE__))
require File.expand_path(path + '/../lib/swinger/lib/swinger')

$CLASSPATH << path + '/../../package/classes'

puts "It takes a while for the scenarios to begin executing, so please be patient..."

$NO_MAC_MENUBAR = true # disable Mac-style menu bars so Swinger can drive the menus
require path + '/../../src/main'
sleep(1)

at_exit do 
  java.lang.System.exit(0)
end