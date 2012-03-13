Given /^I am logged in as ([^"]*) with pass ([^"]*)$/ do |username, pass|

  header "Accept", "application/json"
  header "Content-Type", "application/json"
  get key_url(:id => "0108001416"), {:password => pass} 

  last_response.should be_ok
  @key = JSON.parse last_response.body 

end

When /^I send a GET request for "([^"]*)" with the user's key$/ do | path |
  get path, @key
end


Then /^I should have the following informations in (JSON|XML) format:$/ do | format, table|

  content_type  = "application/#{format.downcase}"
  last_response.content_type.should  have_content content_type 

  response_data = ActiveSupport::JSON.decode last_response.body

  attributes  = table.headers
  expected    = table.rows.first
  actual      = response_data.values_at(*attributes).map(&:to_s)
  actual.should == expected

end
