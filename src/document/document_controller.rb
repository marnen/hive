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
    instance = self.class.create_instance
    instance.open unless instance.nil?
  end

  def self.create_instance(filename = nil)
    if filename.nil?
      # TODO: put all this dialog code somewhere else!
      if $MOCK_FILE_CHOOSERS
        filename = javax.swing.JOptionPane.show_input_dialog(nil, _('Enter file path:'), _('New'), javax.swing.JOptionPane::QUESTION_MESSAGE)
        if filename.nil?
          return nil
        else
          filename = File.expand_path filename
        end
      else
        dialog = java.awt.FileDialog.new(nil, _('New'), java.awt.FileDialog::SAVE)
        dialog.show
        if dialog.file.nil?
          # User cancelled without selecting a file
          return nil
        end
        filename = dialog.directory + dialog.file
      end
    end

    @@count += 1
    super()
  end

  protected

  def self.reset_count
    @@count = 0
  end
end
