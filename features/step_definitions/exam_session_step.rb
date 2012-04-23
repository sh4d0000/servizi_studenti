require 'uri' 

Then /^the sessions should be the followings:$/ do | table |

  last_response.content_type.should  have_content @content_type 

  response_data = get_hash_response["exam_sessions"]

  actual = [] 
  expected = []

  response_data.each do | attributes |
    hash = @format == :json ? attributes["exam_session"] : attributes
    actual << ExamSession.new( hash )
  end

  
  table.hashes.each do | attributes |
    expected << ExamSession.new( attributes )
    actual.should include( expected.last )
  end

end


Given /^I have a prenotation url from an exam session$/ do

  get "/sessions", @key
  data = get_hash_response["exam_sessions"][1]
  data = data["exam_session"] if @format == :json

  @prenotation_url = URI.escape(data["prenotation_url"], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")) 

end

When /^I send a POST request to "([^"]*)" with the user's key and prenotation url$/ do | path |
  
  body = @key.clone
  body["prenotation_url"] = @prenotation_url
  
  body = @format == :json ? body.to_json : body.to_xml 

  post path, body
end

Then /^the response should have a booking number$/ do
  data = get_hash_response

  data["booking_number"].should > 0
end

Then /^the bookings should be the followings:$/ do |table|
  last_response.content_type.should  have_content @content_type 

  puts get_hash_response
  response_data = get_hash_response["exam_bookings"]
  puts response_data

  actual = [] 
  expected = []

  response_data.each do | attributes |
    hash = @format == :json ? attributes["exam_booking"] : attributes
    actual << ExamBooking.new( hash )
  end

  
  table.hashes.each do | attributes |
    expected << ExamBooking.new( attributes )
    actual.should include( expected.last )
  end
end

Given /^I have a delete prenotation url from an exam booking$/ do

  get "/sessions/bookings", @key
  data = get_hash_response["exam_bookings"][0]
  data = data["exam_booking"] if @format == :json

  @delete_prenotation_url = URI.escape(data["delete_prenotation_url"], Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")) 

end

When /^I send a DELETE request to "([^"]*)" with the user's key and delete prenotation url$/ do | path |
  
  body = @key.clone
  body["delete_prenotation_url"] = @delete_prenotation_url
  
  body = @format == :json ? body.to_json : body.to_xml 

  delete path, body
end
