class ApplicationView < Monkeybars::View
  # Add content here that you want to be available to all the views in your application
  include GetText
  bindtextdomain APP_NAME
end