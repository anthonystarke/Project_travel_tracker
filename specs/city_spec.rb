require('MINITEST/AUTORUN')
require('MINITEST/RG')

require_relative('../models/country')
require_relative('../models/city')
require_relative('../db/sql_runner')

class TestCity < Minitest::Test

  def setup


  end

  # def test_city_name
  #   assert_equal("Edinburgh",@city_1.name)
  # end

  def test_city_find
    city_1 = City.find(3)
    assert_equal("Paris",city_1.name)
  end

  def test_city_country
    city_1 = City.find(3)
    assert_equal("Paris",city_1.country.name)
  end


end
