def get_hash_response

  response_data = ActiveSupport::JSON.decode last_response.body  if @format == :json
  response_data = Hash.from_xml( last_response.body )            if @format == :xml 

  response_data

end
