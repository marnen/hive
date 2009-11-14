# This is a Ruby table model implementation inheriting from javax.swing.DefaultTableModel.
class DataTableModel < javax.swing.table.DefaultTableModel
  require 'row_header_model'
  
  def column_count
    2
  end

  def row_count
    10
  end

  # Returns a JTable that can serve as a RowHeaderView for this table.
  def row_header_view
    # TODO: refactor this into its own JTable subclass so this can all be in the constructor.
    @header_renderer ||= javax.swing.table.JTableHeader.new.default_renderer
    view = javax.swing.JTable.new RowHeaderModel.new(row_count)
    view.set_default_renderer(java.lang.Number, @header_renderer)
    view.preferred_scrollable_viewport_size = view.preferred_size
    view
  end

  def value_at(row, col)
    "R#{row}, C#{col}"
  end

  # Define some Java-style aliases, since these are already defined in the superclass.
  [:getColumnCount, :getRowCount, :getValueAt].each do |method|
    alias_java_method method
  end
end