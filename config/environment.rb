# Load the Rails application.
require_relative 'application'

# Load the app's custom environment variables here, before environments/*.rb
application_environment_variables = File.join(Rails.root, 'config', 'initializers', 'application_environment_variables.rb')
load(application_environment_variables) if File.exists?(application_environment_variables)

# Initialize the Rails application.
Rails.application.initialize!