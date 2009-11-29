class DocumentController < ApplicationController
  set_model 'DocumentModel' do |model|
    # Workaround since {DocumentModel.new @filename} doesn't work -- see http://kenai.com/jira/browse/MONKEYBARS-15
    model.new_file = @new_file
    model.filename = @filename
  end

  set_view 'DocumentView'
  #set_close_action :exit

  def file_new_menu_item_action_performed
    instance = self.class.create_instance
    instance.open unless instance.nil?
  end

  def file_open_menu_item_action_performed
    instance = self.class.create_instance(nil, false)
    instance.open unless instance.nil?
  end

  # Creates an instance of the controller for the specified file.
  # If filename is nil, the user is prompted for a filename.
  # If new_file? is true, then a new file is created; otherwise the controller expects the file to exist.
  def self.create_instance(filename = nil, new_file = true)
    dialog_title = new_file ? _('New') : _('Open')
    filename ||= choose_file(dialog_title, new_file ? :save : :load)

    @new_file = new_file
    @filename = filename
    super()
  end
end
