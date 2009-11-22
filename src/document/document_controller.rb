class DocumentController < ApplicationController
  set_model 'DocumentModel' do |model|
    # Workaround since {DocumentModel.new @@count} doesn't work -- see http://kenai.com/jira/browse/MONKEYBARS-15
    model.title = @title
  end
  set_view 'DocumentView'
  set_close_action :exit

  def file_new_menu_item_action_performed
    instance = self.class.create_instance
    instance.open unless instance.nil?
  end

  def self.create_instance(filename = nil)
    filename ||= choose_file

    @title = File.basename filename
    super()
  end
end
