module Admin
  class FoursquareCheckinsTestController < Admin::BaseController
    def new
      @checkin_data_json = JSON.pretty_generate(SoInformed::Foursquare::CheckinData.default(current_user.uid))
    end
  end
end
