# This is a Ruby table model implementation inheriting from javax.swing.DefaultTableModel.
class DataTableModel < javax.swing.table.DefaultTableModel
  require 'row_header_model'

  def initialize
    @data = Array.new(row_count) do |r|
      Array.new(column_count) do |c|
        "R#{r + 1},C#{c + 1}"
      end
    end
  end
  
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

  def set_value_at(value, row, col)
    if row >= row_count or col >= column_count
      raise IndexError, "(#{row}, #{col}) is beyond the maximum coordinates, which are (#{row_count - 1}, #{column_count - 1})."
    end
    @data[row][col] = value
  end

  def value_at(row, col)
    @data[row][col]
  end

  # Define some Java-style aliases, since these are already defined in the superclass.
  [:getColumnCount, :getRowCount, :getValueAt, :setValueAt].each do |method|
    alias_java_method method
  end
end