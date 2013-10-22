class ApplicationController < ActionController::Base

  include SoInformed::Security::ControllerMixin
  include SoInformed::CacheMixin

  protect_from_forgery

  private

  def model_alert(model)
    "Please fix these issues and try again: <ul><li>#{model.errors.full_messages.join("</li><li>")}</li></ul>".html_safe
  end

end
