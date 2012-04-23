When /^I send a GET request for "([^"]*)" with password paramameter "([^"]*)"$/ do |path, pass|

  get path, { password: pass }

end

Then /^the key should be valid$/ do

  response_data = get_hash_response["key"] 

  response_data["P_1XXD"].should_not be_empty
  response_data["P_2XXI"].should_not be_empty
  response_data["P_3XXC"].should_not be_empty

end

Given /^I have an invalid access key$/ do
  @key = {}
  @key["P_1XXD"] = 0 
  @key["P_2XXI"] = 0 
  @key["P_3XXC"] = 0 
end
