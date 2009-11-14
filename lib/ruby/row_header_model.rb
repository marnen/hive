class RowHeaderModel < javax.swing.table.DefaultTableModel
  attr_reader :row_count
  
  def initialize(rows = 0)
    super() # no reason to store actual data since we're just returning coordinates
    @row_count = rows
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
end