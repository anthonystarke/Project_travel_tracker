require('sinatra')
require('sinatra/contrib/all')
require('pry')

require_relative('../models/bucket_list.rb')
require_relative('../models/city.rb')
require_relative('../models/country.rb')
require_relative('../db/sql_runner')

get '/home' do

  @visited_cities = Bucket_List.visited()
  @not_visited_cities = Bucket_List.not_visited()

  @visited_countries = Bucket_List.visited_countries()
  @not_visited_countries = Bucket_List.not_visited_countries()

  erb(:main)

end


get '/visited' do
  @visited = Bucket_List.visited()

  erb(:visited)
end

get '/not-visited' do
  @not_visited = Bucket_List.not_visited()

  erb(:not_visited)
end
