class ApplicationController < Monkeybars::Controller
  require 'document_controller'
  require 'intro_window_controller'
  
  # Add content here that you want to be available to all the controllers
  # in your application

  load_gettext

  class << self
    # Closes all windows and otherwise resets the application to a blank slate.
    def reset
      DocumentController.active_controllers.values do |c|
        c.close
      end
      IntroWindowController.instance.close
      
      startup
    end

    # Starts the application.
    def startup
      # TODO: remove tmpdir from lib/ruby when we remove this line.
      IntroWindowController.instance.open
    end

    # Displays a file chooser dialog with the supplied title and mode.
    # Mode can be :load or :save.
    # Returns the full pathname of the selected file, or nil if the dialog was cancelled.
    # TODO: Should this be in its own class?  Should it return the File object itself?
    def choose_file(title, mode = :save)
      if $MOCK_FILE_CHOOSERS # Fake the dialog since Swinger can't drive AWT widgets
        choose_file_mock title, mode
      else
        choose_file_awt title, mode
      end
    end

    protected

    def choose_file_awt(title, mode)
      java_mode =  java.awt.FileDialog.const_get mode.to_s.upcase!
      dialog = java.awt.FileDialog.new(nil, title, java_mode)
      dialog.show
      if dialog.file.nil? # User cancelled without selecting a file
        return nil
      end
      return dialog.directory + dialog.file
    end

    def choose_file_mock(title, mode)
      filename = javax.swing.JOptionPane.show_input_dialog(nil, _('Enter file path:'), title, javax.swing.JOptionPane::QUESTION_MESSAGE)
      if filename.nil? # User cancelled
        return nil
      else
        return File.expand_path filename
      end
    end
  end
end