class RowHeaderModel < javax.swing.table.DefaultTableModel
  attr_reader :row_count
  # A JTable suitable for use as a RowHeaderView on a JScrollPane.
  attr_reader :table
  
  def initialize(rows = 0)
    super() # no reason to store actual data since we're just returning coordinates
    @row_count = rows
    @table = make_table
  end

  def cell_editable?(row, col)
    false
  end

  def column_count
    1
  end

  def column_class(index)
    if index == 0
      java.lang.Number
    end
  end

  def value_at(row, col)
    row + 1
  end

  # Define some Java-style aliases, since these are already defined in the superclass.
  [:getColumnCount, :getColumnClass, :getRowCount, :getValueAt, :isCellEditable].each do |method|
    alias_java_method method
  end

  protected

  def make_table
    @header_renderer ||= javax.swing.table.JTableHeader.new.default_renderer
    t = javax.swing.JTable.new self
    t.set_default_renderer(java.lang.Number, @header_renderer)
    t.preferred_scrollable_viewport_size = t.preferred_size
    t
  end
end