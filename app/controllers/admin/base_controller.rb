module Admin
  class BaseController < ApplicationController
    prepend_before_filter :ensure_admin
  end
end