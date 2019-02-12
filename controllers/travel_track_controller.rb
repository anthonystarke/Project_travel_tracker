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

get '/upload_image/:id' do
  @location = Bucket_List.find(params[:id])

  erb(:upload_image)
end

post '/save_image/:id' do

  item = Bucket_List.find(params[:id])
  city = item.city

  @filename = params[:file][:filename]
  file = params[:file][:tempfile]

  File.open("./public/#{@filename}", 'wb') do |f|
    f.write(file.read)
  end
  city.photo_loc = "./#{@filename}"
  city.update()

  redirect to '/all'
end

get '/all' do
  @all_locations = Bucket_List.find_all()
  @all_countries = Country.find_all()
  erb(:all)
end

get '/search' do
  @locations_found = Bucket_List.find_by_name(params['search'])
  erb(:search)
end

get '/edit/:id' do
  @item = Bucket_List.find(params[:id])
  erb(:edit)
end

get '/edit-city/:id' do
  @item = Bucket_List.find(params[:id])
  erb(:edit_city)
end

get '/edit-country/:id' do
  @item = Country.find(params[:id])
  erb(:edit_country)
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
  count = Country.find_by_name_count(params["name"])
  # binding.pry
  if(count < 1)
    country_1 = Country.new(params)
    country_1.save()
  end
  redirect to '/add-new'
end

post '/save-changes-city/:id' do

  item = Bucket_List.find(params[:id])
  # binding.pry
  city = item.city
  city.name = params[:city_name]
  city.update()

  redirect to back
end

post '/save-changes-country/:id' do

  country = Country.find(params[:id])
  # binding.pry
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

  count = City.find_by_name_count(params["name"])
  # binding.pry
  if(count < 1)

    city_1 = City.new(params)
    city_1.save()

    details = {
      "visited" => params[:visited],
      "city_id" => city_1.id
    }
    # binding.pry
    bucket_list = Bucket_List.new(details)
    bucket_list.save()
  end
  redirect to back
end
