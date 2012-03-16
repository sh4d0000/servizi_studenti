When /^I send a GET request for "([^"]*)" with password paramameter "([^"]*)"$/ do |path, pass|

  get path, { password: pass }

end

Then /^the key should be valid$/ do

  response_data = get_hash_response["key"] 

  response_data["P_1XXD"].should_not be_empty
  response_data["P_2XXI"].should_not be_empty
  response_data["P_3XXC"].should_not be_empty

end
