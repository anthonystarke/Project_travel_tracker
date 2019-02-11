require_relative('../models/country')
require_relative('../models/city')
require_relative('../models/bucket_list')

Bucket_List.delete_all
City.delete_all
Country.delete_all

@country_1_details = {
  'name' => 'Scotland'
}

@country_2_details = {
  'name' => 'Germany'
}

@country_3_details = {
  'name' => 'France'
}

@country_4_details = {
  'name' => 'Spain'
}

@country_1 = Country.new(@country_1_details)
@country_2 = Country.new(@country_2_details)
@country_3 = Country.new(@country_3_details)
@country_4 = Country.new(@country_4_details)

@country_1.save()
@country_2.save()
@country_3.save()
@country_4.save()

@city_1_details = {
  "name" => "Edinburgh",
  "country_id" => @country_1.id
}
@city_2_details = {
  "name" => "Berlin",
  "country_id" => @country_2.id
}
@city_3_details = {
  "name" => "Paris",
  "country_id" => @country_3.id
}
@city_4_details = {
  "name" => "Barcelona",
  "country_id" => @country_4.id
}

@city_1 = City.new(@city_1_details)
@city_2 = City.new(@city_2_details)
@city_3 = City.new(@city_3_details)
@city_4 = City.new(@city_4_details)

@city_1.save()
@city_2.save()
@city_3.save()
@city_4.save()

@bucket_list_1_details = {
  "visited" => false,
  "city_id" => @city_1.id
}
@bucket_list_2_details = {
  "visited" => false,
  "city_id" => @city_2.id
}
@bucket_list_3_details = {
  "visited" => false,
  "city_id" => @city_3.id
}
@bucket_list_4_details = {
  "visited" => false,
  "city_id" => @city_4.id
}

@bucket_list_1 = Bucket_List.new(@bucket_list_1_details)
@bucket_list_2 = Bucket_List.new(@bucket_list_2_details)
@bucket_list_3 = Bucket_List.new(@bucket_list_3_details)
@bucket_list_4 = Bucket_List.new(@bucket_list_4_details)

@bucket_list_1.save()
@bucket_list_2.save()
@bucket_list_3.save()
@bucket_list_4.save()
