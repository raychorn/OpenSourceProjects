# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_MarsRoverSample2_session',
  :secret      => '65648172acc4c8d58e9cb41b1720409b6a633a8f84391144ee3b1c1f78ebd1e12250209164da67456022717fda631633f550676f459df92bc43c5b5881afd0aa'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
