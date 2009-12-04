$LOAD_PATH.clear #ensure load path is cleared so system gems and libraries are not used (only project gems/libs)
# Load current and subdirectories in src onto the load path
$LOAD_PATH << File.dirname(__FILE__)
Dir.glob(File.expand_path(File.dirname(__FILE__) + "/**/*").gsub('%20', ' ')).each do |directory|
  next if directory =~ /\/gettext\//
  next if directory =~ /\/sequel\//
  # File.directory? is broken in current JRuby for dirs inside jars
  # http://jira.codehaus.org/browse/JRUBY-2289
  $LOAD_PATH << directory unless directory =~ /\.\w+$/
end
# Some JRuby $LOAD_PATH path bugs to check if you're having trouble:
# http://jira.codehaus.org/browse/JRUBY-2518 - Dir.glob and Dir[] doesn't work
#                                              for starting in a dir in a jar
#                                              (such as Active-Record migrations)
# http://jira.codehaus.org/browse/JRUBY-3247 - Compiled Ruby classes produce
#                                              word substitutes for characters
#                                              like - and . (to minus and dot).
#                                              This is problematic with gems
#                                              like ActiveSupport and Prawn

#===============================================================================
# Monkeybars requires, this pulls in the requisite libraries needed for
# Monkeybars to operate.

require 'resolver'

case Monkeybars::Resolver.run_location
when Monkeybars::Resolver::IN_FILE_SYSTEM
  add_to_classpath '../lib/java/monkeybars-1.0.4.jar'
  add_to_load_path '../lib/ruby'
when Monkeybars::Resolver::IN_JAR_FILE
  # Have to do this here so we can require gettext below.
  add_to_load_path 'gettext/lib'
end

require 'monkeybars'

# FastGettext stuff has to be here so application_view can use it.
require 'gettext'
APP_NAME = 'Hive'
class Class
  def load_gettext
    include GetText
    bindtextdomain APP_NAME
  end
end

# End of Monkeybars requires
#===============================================================================
#
# Add your own application-wide libraries below.  To include jars, append to
# $CLASSPATH, or use add_to_classpath, for example:
# 
# $CLASSPATH << File.expand_path(File.dirname(__FILE__) + "/../lib/java/swing-layout-1.0.3.jar")
#
# is equivalent to
#
# add_to_classpath "../lib/java/swing-layout-1.0.3.jar"
#
# There is also a helper for adding to your load path and avoiding issues with file: being
# appended to the load path (useful for JRuby libs that need your jar directory on
# the load path).
#
# add_to_load_path "../lib/java"
#

require 'utilities' # Some common app-wide stuff

require 'application_controller'
require 'application_view'

case Monkeybars::Resolver.run_location
when Monkeybars::Resolver::IN_FILE_SYSTEM
  # Files to be added only when running from the file system go here
  add_to_classpath '../lib/java/h2-1.2.123.jar'
  $LOAD_PATH << File.join(ENV_JAVA['jruby.home'], 'lib/ruby/1.8') # so we can have the standard library
when Monkeybars::Resolver::IN_JAR_FILE
  # Files to be added only when run from inside a jar file
  add_to_load_path 'sequel/lib'
end
