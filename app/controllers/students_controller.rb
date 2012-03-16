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
end
