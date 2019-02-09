require('sinatra')
require('sinatra/contrib/all')


also_reload("./models/*")

get '/' do
  p "Test Text"
end
