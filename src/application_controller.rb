class ApplicationController < Monkeybars::Controller
  # Add content here that you want to be available to all the controllers
  # in your application

  load_gettext

  class << self
    # Closes all windows and otherwise resets the application to a blank slate.
    def reset
      DocumentController.active_controllers.values do |c|
        c.close
      end
      DocumentController.send :reset_count
    end

    # Displays a file chooser dialog, and returns the full pathname of the selected file, or nil if the dialog was cancelled.
    # TODO: Should this be in its own class?  Should it return the File object itself?
    def choose_file
      if $MOCK_FILE_CHOOSERS # Fake the dialog since Swinger can't drive AWT widgets
        choose_file_mock
      else
        choose_file_awt
      end
    end

    protected

    def choose_file_awt
      dialog = java.awt.FileDialog.new(nil, _('New'), java.awt.FileDialog::SAVE)
      dialog.show
      if dialog.file.nil? # User cancelled without selecting a file
        return nil
      end
      return dialog.directory + dialog.file
    end

    def choose_file_mock
      filename = javax.swing.JOptionPane.show_input_dialog(nil, _('Enter file path:'), _('New'), javax.swing.JOptionPane::QUESTION_MESSAGE)
      if filename.nil? # User cancelled
        return nil
      else
        return File.expand_path filename
      end
    end
  end
end