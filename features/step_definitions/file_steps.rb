Then /^I should have a (temp(?:orary)? )?file called "([^\"]*)"$/ do |temp, name|
  prefix = temp.to_s.empty? ? nil : $TEMP_DIR
  File.should exist(File.join [prefix, name].compact)
end