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

get'/all' do
  @all_locations = Bucket_List.find_all()

  erb(:all)
end

get '/edit/:id' do
  @item = Bucket_List.find(params[:id])
  erb(:edit)
end

post '/delete/:id' do
  item = Bucket_List.find(params[:id])
  city = item.city
  country = item.city.country
  # binding.pry
  Bucket_List.delete(item.id)
  City.delete(city.id)
  if country.any_cities < 1
    Country.delete(country.id)
  end
  redirect back
  # redirect to '/visited'
end

post '/save-country' do
  country_1 = Country.new(params)
  country_1.save()
  redirect to '/add-new'
end

post '/save-changes/:id' do

  item = Bucket_List.find(params[:id])
  # binding.pry
  city = item.city
  city.name = params[:city_name]
  city.update()

  country = item.city.country
  country.name = params[:country_name]
  country.update()

  redirect to back
end

# This is the action that will change the status of a not visited country/city to
post '/visited-city/:id' do
  found_item = Bucket_List.find(params[:id])
  found_item.visited = true
  found_item.update()
  redirect to back
end

# This is the action that will change the status of a visited country/city to NOT
post '/not-visited-city/:id' do
  found_item = Bucket_List.find(params[:id])
  found_item.visited = false
  found_item.update()
  redirect to back
end

post '/save-city' do
  city_1 = City.new(params)
  city_1.save()

  details = {
    "visited" => params[:visited],
    "city_id" => city_1.id
  }
  # binding.pry
  bucket_list = Bucket_List.new(details)
  bucket_list.save()
  redirect to back
end

get '/add-new' do
  @all_countries = Country.find_all()
  # binding.pry
  erb(:add_new)
end

get '/visited' do
  @visited = Bucket_List.visited()
  # binding.pry
  erb(:visited)
end

get '/not-visited' do
  @not_visited = Bucket_List.not_visited()
  erb(:not_visited)
end
