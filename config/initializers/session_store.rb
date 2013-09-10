# Be sure to restart your server when you modify this file.

session_store_type = Rails.env.production? ? :dalli_store : :cookie_store

SoInformed::Application.config.session_store session_store_type, :key => '_sis'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# SoInformed::Application.config.session_store :active_record_store
