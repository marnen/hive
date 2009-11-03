path = File.expand_path(File.dirname(__FILE__))
require File.expand_path(path + '/../../lib/swinger/lib/swinger')

require File.expand_path(path + '/../../../dist/hive.jar')

puts "It takes a while for the scenarios to begin executing, so please be patient..."

Java::org::rubyforge::rawr::Main.main([].to_java(:string))
sleep(1)

at_exit do 
  java.lang.System.exit(0)
end