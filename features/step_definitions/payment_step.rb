Then /^the payments should be the followings:$/ do | table |

  last_response.content_type.should  have_content @content_type 

  response_data = get_hash_response["payments"]

  actual = [] 
  expected = []

  response_data.each do | attributes |
    hash = @format == :json ? attributes["payment"] : attributes
    actual << Payment.new( hash )
  end

  
  table.hashes.each do | attributes |
    expected << Payment.new( attributes )
    actual.should include( expected.last )
  end

end


Then /^the payments list should be empty$/ do

  last_response.content_type.should  have_content @content_type 

  response_data = get_hash_response
  puts response_data
  response_data["payments"].should be_empty if @format == :json



end
