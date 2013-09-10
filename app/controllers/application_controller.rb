class ApplicationController < ActionController::Base

  include SoInformed::Security::ControllerMixin
  include SoInformed::CacheMixin

  protect_from_forgery

end
