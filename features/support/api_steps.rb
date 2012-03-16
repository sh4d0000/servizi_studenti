
Given /^I am a valid API user$/ do
  @user = Factory(:user)
  authorize(@user.email, @user.password)
end

Given /^I send and accept ([^\"]*)$/ do | format |
  @format = format.downcase.to_sym

@content_type  = "application/#{@format.to_s}"
header 'Accept', @content_type
header 'Content-Type', @content_type

end

When /^I send a GET request for "([^\"]*)"$/ do |path|
  get path
end

When /^I send a POST request to "([^\"]*)" with the following:$/ do |path, body|
  post path, body
end

When /^I send a PUT request to "([^\"]*)" with the following:$/ do |path, body|
  put path, body
end

When /^I send a DELETE request to "([^\"]*)"$/ do |path|
  delete path
end

Then /^the response code should be ([^\"]*)$/ do |status|
  last_response.status.should == status.to_i
end

Then /^the XML response should be a "([^\"]*)" array with (\d+) "([^\"]*)" elements$/ do |tag, number_of_children, child_tag|
  page = Nokogiri::XML(last_response.body)
  page.xpath("//#{tag}/#{child_tag}").length.should == number_of_children.to_i
end

Then /^the JSON response should be an array with (\d+) "([^\"]*)" elements$/ do |number_of_children, name|
  page = JSON.parse(last_response.body)
  page.map { |d| d[name] }.length.should == number_of_children.to_i
end

Given /^I am logged in as ([^"]*) with pass ([^"]*)$/ do |username, pass|

  header "Accept", "application/json"
  header "Content-Type", "application/json"
  get key_url(id: username), {password: pass} 

  @key = JSON.parse( last_response.body )["key"]

end

When /^I send a GET request for "([^"]*)" with the user's key$/ do | path |
  get path, @key
end



