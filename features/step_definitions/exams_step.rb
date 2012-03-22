Then /^the exams should be the followings:$/ do | table |

  last_response.content_type.should  have_content @content_type 

  response_data = get_hash_response

  actual = [] 
  expected = []

  response_data["exams"].each do | attributes |
    hash = @format == :json ? attributes["exam"] : attributes
    actual << Exam.new( hash )
  end

  
  table.hashes.each do | attributes |
    expected << Exam.new( attributes )
    actual.should include( expected.last )
  end

end
