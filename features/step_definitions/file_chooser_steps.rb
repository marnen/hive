Given t(/^the file chooser "([^\"]*)" is visible$/) do |name|
  container.set dialog(name, nil)
end

Given t(/^the file chooser "([^\"]*)" is the container$/) do |name|
  container.set dialog(name, nil)
end

When t(/^I select the (temp(?:orary)? )?file "([^\"]*)"$/) do |temp, name|
  prefix = temp.to_s.empty? ? nil : $TEMP_DIR
  When %Q(I fill the text field "#1" with "#{File.join [prefix, name].compact}")
end

When t(/^I approve the file chooser$/) do
  When %Q(I click the button "OK")
end

When t(/^I close the file chooser "([^\"]*)"$/) do |name|
  dialog(name, nil).close
end

Then t(/^I should (not )*see the file chooser "([^\"]*)"$/) do |negation, name|
  if negation
    expect_timeout(:id => "ComponentOperator.WaitComponentTimeout") do
      dialog(name, nil)
    end
  else
    dialog(name, nil).visible?.should be_true
  end
end
