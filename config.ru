require_relative 'App'
require 'rack/cors'

use Rack::Cors do 
    allow do
      origins 'https://objective-austin-693728.netlify.app/'
      resource '*', :headers => :any, :methods => [:get, :post, :delete, :options]
    end
  end

# Load controllers
Dir[File.join(File.dirname(__FILE__), 'app/controllers', '**', '*.rb')].sort.each {|file| require file }

run App.router
