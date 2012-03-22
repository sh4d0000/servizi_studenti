class StudentsPortalService

  BASE = "http://www.servizi.uniparthenope.it/self/"
  MENU_URL = "http://www.servizi.uniparthenope.it/self/gissweb.welcome"
  PERSONAL_DATA_URL = "http://www.servizi.uniparthenope.it/self/SSGISSWU.SSGISSWU"
  STUDY_PLAN_URL = "http://www.servizi.uniparthenope.it/self/SSGISSW2.SSGISSW2"
  PASSED_EXAMS_URL = "http://www.servizi.uniparthenope.it/self/SSGISSW5.SSGISSW5"
  ISEE_URL = "http://www.servizi.uniparthenope.it/self/SSIIOLKH.SSIIOLKH"
  PAYMENTS_MADE_URL = "http://www.servizi.uniparthenope.it/self/SSGISSW6.SSGISSW6"
  PAYMENTS_IN_DEBT_URL = "http://www.servizi.uniparthenope.it/self/SSGISSW7.SSGISSW7"

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

    piano_studi_href = doc.css("a:contains('Piano Studi')").attribute("href").value
    query_params =  Rack::Utils.parse_query URI( piano_studi_href ).query

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


  def self.get_passed_exams( key )

    doc = Nokogiri::HTML( HTTParty.get( MENU_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC }))

    exams_href = doc.css("a:contains('Esami')")[1].attribute("href").value
    query_params =  Rack::Utils.parse_query URI( exams_href ).query

    doc = Nokogiri::HTML( HTTParty.get( PASSED_EXAMS_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"] }))

    exams = []

    doc.css("table tr").each do | row |

      tds = row.css("td")

      if not tds.empty?
        exam = {}
        exam[:code]    = tds[0].text.strip.downcase
        exam[:name]    = tds[1].text.strip.downcase
        exam[:date]    = tds[2].text.strip.downcase
        exam[:outcome] = tds[3].text.strip.downcase

        exams << Exam.new( exam )
      end

    end

    exams

  end

  def self.get_isee( key )

    doc = Nokogiri::HTML( HTTParty.get( MENU_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC }))

    anagrafica_href = doc.css("a:contains('ISEE')")[1].attribute("href").value
    query_params =  Rack::Utils.parse_query URI( anagrafica_href ).query

    doc = Nokogiri::HTML( HTTParty.get( ISEE_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"] }))

    data = {}

    doc.css("table tr" ).each do | row |
      data[row.css("th").text.strip.downcase] = row.css("td").text.strip.downcase
    end

    cognome_nome = data["cognome/nome"].split(" ")
    data["nome"] = cognome_nome[1]
    data["cognome"] = cognome_nome[0]

    Isee.new( {
      name:                    data["nome"], 
      surname:                 data["cognome"], 
      student_code:            data["matricola"], 
      date_of_birth:           data["il"], 
      place_of_birth:          data["nato/a a"], 
      tax_code:                data["codice fiscale"], 
      value_scale_equivalence: data["valore scala di equivalenza"].sub(",", "."), 
      ise:                     data["ise"].sub(",", "."), 
      isee:                    data["isee"].sub(",", "."),
      caf_protocol_number:     data["numero di protocollo caf"]
    })

  end


  def self.get_payments( key, status )

    doc = Nokogiri::HTML( HTTParty.get( MENU_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC }))

    if status == :made
      link = "Effettuati"
      url = PAYMENTS_MADE_URL
    elsif status == :in_debt
      link = "In Debito"
      url = PAYMENTS_IN_DEBT_URL
    end

    payments_href = doc.css("a:contains('#{link}')").attribute("href").value
    query_params =  Rack::Utils.parse_query URI( payments_href ).query

    doc = Nokogiri::HTML( HTTParty.get( url, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"] }))

    payments = []

    doc.css("table tr").each do | row |

      tds = row.css("td")

      if not tds.empty?
        payment = {}
        payment[:academic_year] = tds[0].text.strip.downcase
        payment[:code]          = tds[1].text.strip.downcase
        payment[:date]          = tds[4].text.strip.downcase
        payment[:description]   = tds[2].text.strip.downcase
        payment[:amount]        = tds[3].text.strip.downcase
        payment[:status]        = status

        payments << Payment.new( payment )
      end

    end

    payments

  end

  def self.get_exam_sessions( key )

    doc = Nokogiri::HTML( HTTParty.get( MENU_URL, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC }))

    href = doc.css("a:contains('Prenotazioni')").attribute("href").value
    query_params =  Rack::Utils.parse_query URI( href ).query

    doc = Nokogiri::HTML( HTTParty.get( BASE + href, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"] }))
    href = doc.css("a:contains('Cerca')").attribute("href").value

    doc = Nokogiri::HTML( HTTParty.get( BASE + href, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"] }))
    href = doc.css("a:contains('Qui')").attribute("href").value

    links = []
    i = 1
    doc = Nokogiri::HTML( HTTParty.get( BASE + href, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"], p_page_num: i }))

    while doc.css("table tr td").size != 0

      doc.css("table tr td > a").each do | link |
        links << link.attribute("href")
      end
      
      i += 1
      puts i
      doc = Nokogiri::HTML( HTTParty.get( BASE + href, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"], p_page_num: i }))
    end

    puts "Link n:"
    puts links.size 

    sessions = []

    links.each do | link |
      
      details_doc = Nokogiri::HTML( HTTParty.get( BASE + link, query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: query_params["P_3XXC"] }))

      exam_session = {}

      exam_session[:teaching] = details_doc.css("h3:contains('Insegnamento')").text.downcase.split("insegnamento di")[1].strip
      exam_session[:course] = details_doc.css("li:contains('Corso di Laurea') span").text.downcase.strip
      exam_session[:address] = details_doc.css("li:contains('Indirizzo') span").text.downcase.strip
      exam_session[:cfu] = details_doc.css("li:contains('CFU') span").text.downcase.strip
      exam_session[:ssd] = details_doc.css("li:contains('SSD') span").text.downcase.strip

      details_doc.css("ol > li").each do | fragment |

        date_time = fragment.css("span")[0].text.downcase.strip
        exam_session[:date] = date_time[12..21].strip
        exam_session[:time] = date_time[43..47].strip

        range_text = fragment.css("span")[1].text.downcase.split(" ")
        exam_session[:prenotation_range] = range_text[3] + " - " + range_text[5]

        list_items = fragment.css("ul li")
        exam_session[:classroom] = list_items[0].text.split("Aula: ")[1].downcase.strip
        exam_session[:professor] = list_items[1].text.split("Docente: ")[1].downcase.strip
        exam_session[:notes] = list_items[2].text.split("Nota: ")[1].downcase.strip if list_items[2]

        sessions << ExamSession.new( exam_session )

      end

    end

    sessions
  end
end
