path = File.expand_path(File.dirname(__FILE__))
require File.expand_path(path + '/../lib/swinger/lib/swinger')
require 'tmpdir' # so Dir.mktmpdir will work

$CLASSPATH << path + '/../../package/classes'

puts "It takes a while for the scenarios to begin executing, so please be patient..."

$NO_MAC_MENUBAR = true # disable Mac-style menu bars so Swinger can drive the menus
$NO_QUAQUA = true # Turn off Quaqua since it seems to cause problems for Swinger
# TODO: put those global variables in a config object or something
require path + '/../../src/main'
sleep(1)

#
# Start each scenario from a clean slate.

Before do
  $TEMP_DIR = Dir.mktmpdir APP_NAME # Make a temp directory
end

After do
  FileUtils.rm_r $TEMP_DIR # Get rid of the temp directory
  ApplicationController.reset
end

at_exit do
  java.lang.System.exit(0)
end