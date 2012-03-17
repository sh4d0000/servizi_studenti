Then /^the study plan should have the following teachings:$/ do | table |

  last_response.content_type.should  have_content @content_type 
  data =  get_hash_response["study_plan"]["teachings"] 

  actual = [] 
  expected = []

  data.each do | attributes |
    actual << Teaching.new( attributes )
  end
  
  table.hashes.each do | attributes |
    expected << Teaching.new( attributes )
    actual.should include( Teaching.new( attributes ) )
  end

end
