Given t(/^the file chooser "([^\"]*)" is visible$/) do |name|
  container.set file_chooser
  file_chooser.should be_visible
  file_chooser.dialog_title.should == name
end

Given t(/^the file chooser "([^\"]*)" is the container$/) do |name|
  container.set file_chooser
end

Then t(/^I should (not )*see the file chooser "([^\"]*)"$/) do |negation, name|
  if negation
    expect_timeout(:id => "FileChooserWaiter.WaitFileChooserTimeout") do
      file_chooser
    end
  else
    file_chooser.visible?.should be_true
  end
end