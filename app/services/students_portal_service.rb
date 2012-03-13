class StudentsPortalService

  MENU_URL = "http://www.servizi.uniparthenope.it/self/gissweb.welcome"
  PERSONAL_DATA_URL = "http://www.servizi.uniparthenope.it/self/SSGISSWU.SSGISSWU"

  def self.get_student( key )

    doc = Nokogiri::HTML( HTTParty.get( MENU_URL, :query => { :P_1XXD => key.P_1XXD, :P_2XXI => key.P_2XXI, :P_3XXC => key.P_3XXC }))

    anagrafica_href = doc.css("a:contains('Anagrafica')").attribute("href").value
    query_params =  Rack::Utils.parse_query URI( anagrafica_href ).query

    doc = Nokogiri::HTML( HTTParty.get( PERSONAL_DATA_URL, :query => { :P_1XXD => key.P_1XXD, :P_2XXI => key.P_2XXI, :P_3XXC => query_params["P_3XXC"] }))

    data = {}

    doc.css("table tr" ).each do | row |
      data[row.css("th").text.strip.downcase] = row.css("td").text.strip.downcase
    end

    place_and_date_of_birth = doc.css("table > td").text.split("-")
    data["luogo di nascita"] = place_and_date_of_birth[0].strip.downcase
    data["data di nascita"] = place_and_date_of_birth[1].strip.downcase

    Student.new( {
      :name => data["nome"], 
      :surname => data["cognome"], 
      :gender => data["sesso"], 
      :date_of_birth => data["data di nascita"], 
      :place_of_birth => data["luogo di nascita"], 
      :citizenship  => data["cittadinanza"], 
      :tax_code => data["codice fiscale"] 
    })

  end


end
