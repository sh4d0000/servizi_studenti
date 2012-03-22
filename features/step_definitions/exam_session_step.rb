Then /^the sessions should be the followings:$/ do | table |

  last_response.content_type.should  have_content @content_type 

  response_data = get_hash_response["exam_sessions"]
  puts response_data

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
