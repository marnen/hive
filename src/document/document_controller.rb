class DocumentController < ApplicationController
  # Keep track of how many instances we've made
  @@count ||= 1
  
  set_model 'DocumentModel' do |model|
    # Workaround since {DocumentModel.new @@count} doesn't work -- see http://kenai.com/jira/browse/MONKEYBARS-15
    model.count = @@count
  end
  set_view 'DocumentView'
  set_close_action :exit

  def file_new_menu_item_action_performed
    self.class.create_instance.open
  end

  def self.create_instance
    @@count += 1
    super
  end

  protected

  def self.reset_count
    @@count = 0
  end
end
