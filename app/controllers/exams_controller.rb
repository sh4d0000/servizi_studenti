class ExamsController < ApplicationController
  respond_to :xml, :json

  # GET /exams/sessions
  def  get_sessions

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    sessions = StudentsPortalService.get_exam_sessions( key )

    puts sessions.size

    respond_to do |format|
      format.xml {  render :xml => sessions == [] ? '<exam_sessions type="array"></exam_sessions>' : sessions }
      format.json { render :json => {exam_sessions: sessions}.to_json }
    end
  end
end
