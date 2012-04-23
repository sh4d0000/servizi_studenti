class ApplicationController < ActionController::Base
  include Exceptions

  protect_from_forgery
  rescue_from Exceptions::Unauthorized, :with => :deny_access # self defined exception

  protected
    def deny_access
      render nothing: true, status: 401
    end
end
