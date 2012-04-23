class StudentsController < ApplicationController
  respond_to :json, :xml

  # GET /students/1
  def show

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    student = StudentsPortalService.get_student( key )

    respond_with student
  end

  # GET /students/:id/key
  def key 

    key = AccessKeyService.retrieve params[:id], params[:password] 
    key ? respond_with( key, :status => :ok ) :  head( :unauthorized )

  end

  # GET /students/:id/study_plan
  def get_study_plan 

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    study_plan = StudentsPortalService.get_study_plan( key )

    respond_with study_plan, :include => :teachings
  end

  # GET /students/:id/passed_exams
  def get_passed_exams 

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    passed_exams = StudentsPortalService.get_passed_exams( key )

    respond_to do |format|
      format.xml { render :xml => passed_exams }
      format.json { render :json => {exams: passed_exams}.to_json }
    end

  end

  # GET /students/:id/isee
  def get_isee

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    isee = StudentsPortalService.get_isee( key )

    respond_with isee 
  end

  # GET /students/:id/payments/:status
  def get_payments

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    payments = StudentsPortalService.get_payments( key, params[:status].downcase.to_sym)

    respond_to do |format|
      format.xml {  render :xml => payments == [] ? '<payments type="array"></payments>' : payments }
      format.json { render :json => {payments: payments}.to_json }
    end

  end
end
