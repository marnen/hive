Given /^I have a new document$/ do
  DocumentController.create_instance.open
end

Then /^it should contain a table$/ do
  table.should_not be_nil
end

Then /^the table should not be empty$/ do
  table.column_count.should > 0
end