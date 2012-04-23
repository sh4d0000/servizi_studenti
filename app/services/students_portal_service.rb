module StudentsPortalService

  extend self

  BASE = "http://www.servizi.uniparthenope.it/self/"
  HOME_URL = BASE + "gissweb.welcome"

  @@menu_links = { 
    personal_data: "Anagrafica",
    study_plan: "Piano Studi",
    passed_exams: "Esami",
    isee: "ISEE",
    made: "Effettuati",
    in_debt: "In Debito",
    bookings: "Esami prenotati",
    book: "Prenotazioni"
  }

  private

  def visit_menu_link link, options={}

    doc = visit HOME_URL, options
    raise Exceptions::Unauthorized if (link = doc.at_css("a[href != '#']:contains('#{link}')")) == nil
    href = link[:href]

    visit BASE + href 

  end

  def visit url, options={} 

    Nokogiri::HTML( HTTParty.get( url, options))

  end

  public
  def get_student( key )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit_menu_link @@menu_links[:personal_data], options 

    data = {}
  
    doc.css('table tr' ).each do | row |
      data[row.css("th").text.normalize] = row.css("td").text.normalize
    end

    place_and_date_of_birth = doc.css('table > td')
    data['luogo di nascita'] = place_and_date_of_birth.text[/.* \(..\)/].normalize
    data['data di nascita'] =  place_and_date_of_birth.text[/\d{2}\/\d{2}\/\d{4}/]


    Student.new( {
      name:            data['nome'],
      surname:         data['cognome'],
      gender:          data['sesso'],
      date_of_birth:   data['data di nascita'],
      place_of_birth:  data['luogo di nascita'],
      citizenship:     data['cittadinanza'],
      tax_code:        data['codice fiscale']
    })

  end

  def get_study_plan( key )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit_menu_link @@menu_links[:study_plan], options 

    data = []
    year = 0

    doc.css("table" ).each do | table |
      year += 1

    table.css("tr").each do |row|

      tds = row.css("td")

      unless tds.empty?
        teaching = {}
        teaching[:name]         = tds[0].text.normalize
        teaching[:outcome]      = tds[1].text.normalize
        teaching[:cfu]          = tds[2].text.normalize
        teaching[:taf]          = tds[3].text.normalize
        teaching[:ssd]          = tds[4].text.normalize
        teaching[:program_year] = year

        data << Teaching.new( teaching )
      end

    end

    end

    StudyPlan.new( {teachings: data} )

  end


  def get_passed_exams( key )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit_menu_link @@menu_links[:passed_exams], options

    exams = []

    doc.css("table tr").each do | row |

      tds = row.css("td")

      unless tds.empty?
        exam = {}
        exam[:code]    = tds[0].text.normalize
        exam[:name]    = tds[1].text.normalize
        exam[:date]    = tds[2].text.normalize
        exam[:outcome] = tds[3].text.normalize

        exams << Exam.new( exam )
      end

    end

    exams

  end

  def book_exam_session( key, booking_url )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit booking_url, options 

    u_text =  doc.css("u:contains('Ordine di prenotazione')").text.split('"')
    booking_number = u_text[1].to_i

  end

  def delete_booking( key, delete_booking_url )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit delete_booking_url, options 

    not doc.css("p:contains('successo')").text.empty?

  end

  def get_isee( key )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit_menu_link @@menu_links[:isee], options

    data = {}

    doc.css("table tr" ).each do | row |
      data[row.css("th").text.normalize] = row.css("td").text.normalize
    end

    match = / /.match data[ "cognome/nome" ] 
    data["nome"] = match.post_match
    data["cognome"] = match.pre_match

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


  def get_payments( key, status )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit_menu_link @@menu_links[status], options

    payments = []

    doc.css("table tr").each do | row |

      tds = row.css("td")

      unless tds.empty?
        payment = {}
        payment[:academic_year] = tds[0].text.normalize
        payment[:code]          = tds[1].text.normalize
        payment[:date]          = tds[4].text.normalize
        payment[:description]   = tds[2].text.normalize
        payment[:amount]        = tds[3].text.normalize
        payment[:status]        = status

        payments << Payment.new( payment )
      end

    end

    payments

  end

  def get_exam_sessions( key )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit_menu_link @@menu_links[:book], options

    href = doc.at_css("a:contains('Cerca')")[:href]

    doc  = visit BASE + href
    href = doc.at_css("a:contains('Qui')")[:href]

    links = []
    i = 1
    doc = visit BASE + href, query: {p_page_num: i} 

    while doc.css("table tr td").size != 0

      doc.css("table tr td > a").each do | link |
        links << link[:href]
      end

      i += 1
      doc = visit  BASE + href, query: { p_page_num: i }
    end

    sessions = []

    links.each do | link |

      details_doc = visit BASE + link

      exam_session = {}

      exam_session[:teaching] = details_doc.css("h3:contains('Insegnamento')").text.downcase.split("insegnamento di")[1].strip
      exam_session[:course] = details_doc.css("li:contains('Corso di Laurea') span").text.normalize
      exam_session[:address] = details_doc.css("li:contains('Indirizzo') span").text.normalize
      exam_session[:cfu] = details_doc.css("li:contains('CFU') span").text.normalize
      exam_session[:ssd] = details_doc.css("li:contains('SSD') span").text.normalize

      details_doc.css("ol > li").each do | fragment |

        prenotation_link = fragment.css("a")
        exam_session[:prenotation_url] = BASE + prenotation_link.attribute("href") unless prenotation_link.empty?

        date_time = fragment.css("span")[0].text.normalize
        exam_session[:date] = date_time[12..21].strip + " " +  date_time[43..47].strip

        range_text = fragment.css("span")[1].text.downcase.split(" ")
        exam_session[:prenotation_range] = range_text[3] + " - " + range_text[5]

        classroom = fragment.css("ul li:contains('Aula: ')")
        unless classroom.empty?
          exam_session[:classroom] = classroom.text.split("Aula: ")[1].normalize 
        end

        professor =  fragment.css("ul li:contains('Docente: ')")
        unless professor.empty? 
          exam_session[:professor] = professor.text.split("Docente: ")[1].normalize 
        end

        notes =  fragment.css("ul li:contains('Nota: ')")
        unless notes.empty? 
          exam_session[:notes] = notes.text.split("Nota: ")[1].normalize 
        end

        sessions << ExamSession.new( exam_session )

      end

    end

    sessions
  end

  def get_exam_bookings( key )

    options = {query: { P_1XXD: key.P_1XXD, P_2XXI: key.P_2XXI, P_3XXC: key.P_3XXC } }
    doc = visit_menu_link @@menu_links[:bookings], options

    bookings = []

    doc.css("table tr").each_with_index do | tr_fragment, i |
      if i != 0
        exam_booking = {}

        prenotation_link = tr_fragment.at_css("a[ title *= 'Cancella' ]")[:href]
        exam_booking[:delete_prenotation_url] = BASE + prenotation_link unless prenotation_link.empty?

        link = tr_fragment.at_css("a[ title *= 'dettaglio' ]")[:href]

        details_doc = visit BASE + link


        exam_booking[:teaching] = details_doc.css("h3:contains('Insegnamento')").text.downcase.split("insegnamento di")[1].strip

        details_doc.css("ol > li").each do | fragment |


          date_time = fragment.css("span")[0].text.normalize
          exam_booking[:date] = date_time[12..21].strip + " " + date_time[28..32].strip

          list_items = fragment.css("ul li")
          exam_booking[:classroom] = list_items[0].text.split("Aula: ")[1].normalize
          exam_booking[:professor] = list_items[1].text.split("Docente: ")[1].normalize
          exam_booking[:booking_number] = list_items[3].text.split("N.ro prenotazione: ")[1].normalize
          exam_booking[:notes] = list_items[2].text.split("Nota: ")[1].normalize if list_items[2]

          bookings << ExamBooking.new( exam_booking )

        end
      end
    end

    bookings
  end
end
