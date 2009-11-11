class DocumentView < ApplicationView
  set_java_class 'document.Document'
  raw_mapping :set_window_title, :get_window_title # map window title to model.title

  def set_window_title(model, transfer)
    @main_view_component.title = model.title
  end

  def get_window_title(model, transfer)
    model.title = @main_view_component.title
  end
end
