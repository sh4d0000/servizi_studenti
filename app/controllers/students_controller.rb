require 'httparty'

class StudentsController < ApplicationController

  # GET /students/1
  def show

    key = Key.new( {:P_1XXD => params["P_1XXD"], :P_2XXI => params["P_2XXI"], :P_3XXC => params["P_3XXC"] } )
    student = StudentsPortalService.get_student( key )

    respond_to do |format|
      format.json { render json: student }
    end
  end

  # GET /students/:id/key
  def key 

    key = AccessKeyService.retrieve params[:id], params[:password] 

    respond_to do |format|
      format.json { render json: key }
    end
  end
end
