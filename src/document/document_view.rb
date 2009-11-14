class DocumentView < ApplicationView
  set_java_class 'document.Document'
  map :view => 'data_table.model', :model => :data
  raw_mapping :set_row_header, nil
  raw_mapping :set_window_title, :get_window_title # map window title to model.title

  protected

  def set_row_header(model, transfer)
    scroll_pane.row_header_view = model.data.row_header_view
    # TODO: Refactor the listener into the model so that row_header_view returns a JViewport.
    scroll_pane.row_header.add_change_listener do
      # Scroll main viewport to match header -- see http://www.jguru.com/faq/view.jsp?EID=87579
      scroll_pane.viewport.view_position = java.awt.Point.new(scroll_pane.viewport.view_position.x, scroll_pane.row_header.view_position.y)
    end
  end

  def set_window_title(model, transfer)
    @main_view_component.title = model.title
  end

  def get_window_title(model, transfer)
    model.title = @main_view_component.title
  end
end
