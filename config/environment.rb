# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!
Date::DATE_FORMATS[:default]="%m/%d/%Y"
