class StudentsPortalService

  MENU_URL = "http://www.servizi.uniparthenope.it/self/gissweb.welcome"
  PERSONAL_DATA_URL = "http://www.servizi.uniparthenope.it/self/SSGISSWU.SSGISSWU"
  STUDY_PLAN_URL = "http://www.servizi.uniparthenope.it/self/SSGISSW2.SSGISSW2"

  def self.get_student( key )

    doc = Nokogiri::HTML( HTTParty.get( MENU_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC }))

    anagrafica_href = doc.css("a:contains('Anagrafica')").attribute("href").value
    query_params =  Rack::Utils.parse_query URI( anagrafica_href ).query

    doc = Nokogiri::HTML( HTTParty.get( PERSONAL_DATA_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"] }))

    data = {}

    doc.css("table tr" ).each do | row |
      data[row.css("th").text.strip.downcase] = row.css("td").text.strip.downcase
    end

    place_and_date_of_birth = doc.css("table > td").text.split("-")
    data["luogo di nascita"] = place_and_date_of_birth[0].strip.downcase
    data["data di nascita"] = place_and_date_of_birth[1].strip.downcase

    Student.new( {
      name:            data["nome"], 
      surname:         data["cognome"], 
      gender:          data["sesso"], 
      date_of_birth:   data["data di nascita"], 
      place_of_birth:  data["luogo di nascita"], 
      citizenship:     data["cittadinanza"], 
      tax_code:        data["codice fiscale"] 
    })

  end

  def self.get_study_plan( key )

    doc = Nokogiri::HTML( HTTParty.get( MENU_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC }))

    anagrafica_href = doc.css("a:contains('Piano Studi')").attribute("href").value
    query_params =  Rack::Utils.parse_query URI( anagrafica_href ).query

    doc = Nokogiri::HTML( HTTParty.get( STUDY_PLAN_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"] }))

    data = []
    year = 0

    doc.css("table" ).each do | table |
      year += 1

    table.css("tr").each do |row|

      tds = row.css("td")

      if not tds.empty?
        teaching = {}
        teaching[:name]         = tds[0].text.strip.downcase
        teaching[:outcome]      = tds[1].text.strip.downcase
        teaching[:cfu]          = tds[2].text.strip.downcase
        teaching[:taf]          = tds[3].text.strip.downcase
        teaching[:ssd]          = tds[4].text.strip.downcase
        teaching[:program_year] = year

        data << Teaching.new( teaching )
      end

    end

    end

    StudyPlan.new( {teachings: data} )

  end

end
