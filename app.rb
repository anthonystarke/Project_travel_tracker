require('sinatra')
require('sinatra/contrib/all')

require_relative('./controllers/travel_track_controller.rb')

also_reload("./models/*")


get '/' do
  p "Test Text"
end
