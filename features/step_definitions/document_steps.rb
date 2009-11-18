Given /^I have a new document called "([^\"]*)"$/ do |name|
  DocumentController.create_instance(name).open
end

Then /^it should contain a table$/ do
  table.should_not be_nil
end

Then /^the table should not be empty$/ do
  table.column_count.should > 0
end

When /^I change the cell at row (\d) and column (\d) to "([^\"]*)"$/ do |row, column, value|
  # Subtract 1 to convert 1-based to 0-based coordinates.
  table.change_cell_object(row.to_i - 1, column.to_i - 1, value)
end

When /^I can figure out how to write this, I will/ do
  pending
end