class ApplicationController < Monkeybars::Controller
  # Add content here that you want to be available to all the controllers
  # in your application

  load_gettext

  # Closes all windows and otherwise resets the application to a blank slate.
  def self.reset
    DocumentController.active_controllers.values do |c|
      c.close
    end
    DocumentController.send :reset_count
  end
end