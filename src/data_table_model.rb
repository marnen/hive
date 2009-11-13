module Monkeybars::Inflector
  # Change a method name from Java to Ruby style.
  def rubyize
    self.to_s.underscore.gsub(/^get_/, '')
  end
end

# This is a Ruby table model implementation inheriting from javax.swing.AbstractTableModel.
class DataTableModel < org.marnen.hive.ConcretizedTableModel
  def column_count
    2
  end

  def row_count
    1
  end

  def value_at(x, y)
    "R#{x}, C#{y}"
  end

  # Define some Java-style aliases, since these are already defined in the superclass.
  [:getColumnCount, :getRowCount, :getValueAt].each do |camel|
    alias_method camel, camel.to_s.rubyize.to_sym
  end
end