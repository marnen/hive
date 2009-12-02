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
    # Mode can be :open (with synonym :load) or :save.
    # Returns the full pathname of the selected file, or nil if the dialog was cancelled.
    # TODO: Should this be in its own class?  Should it return the File object itself?
    def choose_file(title, mode = :save)
      choose_file_swing title, mode
    end

    protected

    def choose_file_swing(title, mode)
      mode = :open if mode == :load # support for AWT-style mode
      dialog_type =  javax.swing.JFileChooser.const_get(mode.to_s.upcase + '_DIALOG')
      dialog = javax.swing.JFileChooser.new
      dialog.dialog_title = title
      dialog.dialog_type = dialog_type
      dialog.file_selection_mode = javax.swing.JFileChooser::DIRECTORIES_ONLY
      value = dialog.send "show_#{mode}_dialog", nil
      if value == javax.swing.JFileChooser::APPROVE_OPTION
        dialog.selected_file.absolute_path
      else
        nil
      end
    end
  end
end