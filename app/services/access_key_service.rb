class AccessKeyService
  LOGIN_URL = "http://www.servizi.uniparthenope.it/self/gwebcontroller.gswenter"

  def self.retrieve( username, password )

    doc = Nokogiri::HTML( HTTParty.get( LOGIN_URL, :query => { :p_username => username, :p_password => password }))

    query_params =  Rack::Utils.parse_query URI( doc.css('form').attribute('action').value ).query
    query_params.delete "p_cod_lingua"
    
    Key.new query_params 

  end

end
