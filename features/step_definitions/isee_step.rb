Then /^the response should have the following informations about the isee:$/ do | table |

  last_response.content_type.should  have_content @content_type 

  attributes  = table.headers
  expected    = table.rows.first
  actual      = get_hash_response["isee"].values_at(*attributes).map(&:to_s)
  actual.should == expected

end
