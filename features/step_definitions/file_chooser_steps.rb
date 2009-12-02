Given t(/^the file chooser "([^\"]*)" is visible$/) do |name|
  container.set file_chooser
end

Given t(/^the file chooser "([^\"]*)" is the container$/) do |name|
  container.set file_chooser
end

When t(/^I select the (temp(?:orary)? )?file "([^\"]*)"$/) do |temp, name|
  prefix = temp.to_s.empty? ? nil : $TEMP_DIR
  file_chooser.selected_file = java.io.File.new File.join([prefix, name].compact)
end

When t(/^I approve the file chooser$/) do
  file_chooser.approve_selection
end

When t(/^I close the file chooser "([^\"]*)"$/) do |name|
  file_chooser.close
end

Then t(/^I should (not )*see the file chooser "([^\"]*)"$/) do |negation, name|
  if negation
    expect_timeout(:id => "ComponentOperator.WaitComponentTimeout") do
      file_chooser
    end
  else
    file_chooser.visible?.should be_true
  end
end
