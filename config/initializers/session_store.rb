require 'action_dispatch/middleware/session/dalli_store'

session_store_type = Rails.env.production? ? :dalli_store : :cookie_store

SoInformed::Application.config.session_store session_store_type, :key => '_sis'
