class ExamsController < ApplicationController
  respond_to :xml, :json

  # GET /exams/sessions
  def  get_sessions

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    sessions = StudentsPortalService.get_exam_sessions( key )

    respond_to do |format|
      format.xml {  render :xml => sessions == [] ? '<exam_sessions type="array"></exam_sessions>' : sessions }
      format.json { render :json => {exam_sessions: sessions}.to_json }
    end
  end

  # POST /sessions/booking
  def book

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    booking_number = StudentsPortalService.book_exam_session( key, URI.unescape( params[:prenotation_url] ) )

    booking_number = {booking_number: booking_number}

    respond_to do |format|
      format.xml  { render :xml => booking_number.to_xml }
      format.json { render :json => booking_number.to_json }
    end
    
  end

  # DELETE /sessions/bookings
  def delete_booking

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    result = StudentsPortalService.delete_booking( key, URI.unescape( params[:delete_prenotation_url] ) )

    status = :ok if result

    respond_to do |format|
      format.any  { head status } # only return the status code
    end
  end
    

  def get_bookings

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    bookings = StudentsPortalService.get_exam_bookings( key )

    respond_to do |format|
      format.xml {  render :xml => bookings == [] ? '<exam_bookings type="array"></exam_bookings>' : bookings }
      format.json { render :json => {exam_bookings: bookings}.to_json }
    end
    
  end

end
