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

    respond_with key
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

    respond_with passed_exams
  end

  # GET /students/:id/isee
  def get_isee

    key = Key.new( {P_1XXD: params[:P_1XXD], P_2XXI: params[:P_2XXI], P_3XXC: params[:P_3XXC] } )
    isee = StudentsPortalService.get_isee( key )

    respond_with isee 
  end
end
