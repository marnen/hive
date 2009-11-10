namespace :gettext do
  def load_gettext
    require 'gettext'
    require 'gettext/utils'
  end
 
  desc "Create mo-files for L10n"
  task :pack do
    load_gettext
    GetText.create_mofiles(false, File.dirname(__FILE__) + "/../po", File.dirname(__FILE__) + "/../src/locale")
  end 
 
  desc "Update pot/po files."
  task :find do
    load_gettext
 
    GetText.update_pofiles_org(
      "Hive",
      Dir.glob(File.dirname(__FILE__) + "/../src/**/*.{rb,java}"),
      "version 0.0.1",
      :po_root => File.dirname(__FILE__) + '/../po',
      :msgmerge=>['--sort-output']
    )
  end
end