module SoInformed
  module CacheMixin

    # Add in each of the requirements for a request
    # to be "fresh". When any of these change, a new etag will
    # be generated and content sent to the client.
    def self.included(base)
      base.after_filter :default_etag_check
      base.etag { SoInformed::AppFactory.get_application.version }
      base.etag { flash }
      base.etag { current_user.try(:last_signed_in_at) }
      base.etag { current_user.try(:id) }
    end

    # Determine if the etag has been set, and therefore checked,
    # already. When it hasn't, perform a freshness check which will
    # invoke the default etag properties.
    def default_etag_check
      fresh_when(1) if response.etag.nil?
    end
  end
end