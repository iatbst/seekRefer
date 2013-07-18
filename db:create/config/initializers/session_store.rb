# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_db:create_session',
  :secret      => 'c4b0432809ee7f98b3ee8a20375cbbb3492797a0e87ad33823f82d33351a9f0df4dbfac489070af9214544ac257cf5a11fd84e222522b33846e6960acbca30cf'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
