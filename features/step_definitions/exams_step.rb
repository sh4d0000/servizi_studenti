Then /^the exams should be the followings:$/ do | table |

  last_response.content_type.should  have_content @content_type 

  response_data = ActiveSupport::JSON.decode last_response.body  if @format == :json
  response_data = Hash.from_xml( last_response.body )            if @format == :xml 

  actual = [] 
  expected = []

  if @format == :json
    response_data.each do | attributes |
      actual << Exam.new( attributes["exam"] )
    end
  end


  if @format == :xml
    response_data["exams"].each do | attributes |
      actual << Exam.new( attributes )
    end
  end
  
  table.hashes.each do | attributes |
    expected << Exam.new( attributes )
    actual.should include( Exam.new( attributes ) )
  end

end
