# This is a Ruby table model implementation inheriting from javax.swing.DefaultTableModel.
# TODO: Remove inheritance from DefaultTableModel when appropriate, and just implement TableModel interface directly.
class DataTableModel < javax.swing.table.DefaultTableModel
  require 'row_header_model'
  require 'sequel'

  def initialize(filename)
    super()
    @db = Sequel.connect 'jdbc:h2:file:' + File.expand_path(filename)
    
    # Yes, this is a placeholder table. We'll make this more flexible shortly.
    cols = column_count
    @db.create_table :table do
      primary_key :id
      1.upto(cols).each do |c|
        String "column_#{c}"
      end
    end

    # Make some placeholder data for now.
    @data = @db[:table]
    values = 1.upto(row_count).collect do |r|
      h = {}
      1.upto(column_count) do |c|
        h[:"column_#{c}"] = "R#{r}, C#{c}"
      end
      h
    end
    @data.multi_insert values
  end
  
  def column_count
    2
  end

  def row_count
    10
  end

  # Returns a JViewport wrapped around row_header_view.
  def row_header
    viewport = javax.swing.JViewport.new
    viewport.view = row_header_view
    viewport.add_change_listener do
      # Scroll main viewport to match header -- see http://www.jguru.com/faq/view.jsp?EID=87579
      parent = viewport.parent
      parent.viewport.view_position = java.awt.Point.new(parent.viewport.view_position.x, viewport.view_position.y)
    end
    viewport
  end

  # Returns a JTable that can serve as a RowHeaderView for this table.
  # TODO: remove this method, at least from public interface.
  def row_header_view
    RowHeaderModel.new(row_count).table
  end

  # row and col are 0-based.
  def set_value_at(value, row, col)
    check_row(row, col)
    @data.filter(:id => row + 1).update(:"column_#{col + 1}" => value)
    value
  end

  # row and col are 0-based.
  def value_at(row, col)
    check_row(row, col)
    @data[:id => row + 1][:"column_#{col + 1}"]
  end

  # Define some Java-style aliases, since these are already defined in the superclass.
  [:getColumnCount, :getRowCount, :getValueAt, :setValueAt].each do |method|
    alias_java_method method
  end

  protected

  # Raise IndexError if row and col are out of range for this table.
  def check_row(row, col)
    if row >= row_count or col >= column_count
      raise IndexError, "(#{row}, #{col}) is beyond the maximum coordinates, which are (#{row_count - 1}, #{column_count - 1})."
    end
  end
end