require('MINITEST/AUTORUN')
require('MINITEST/RG')

require_relative('../models/country')
require_relative('../db/sql_runner')

class TestCountry < Minitest::Test

  def setup

    @country_1_details = {
      'name' => 'Scotland'
    }
    @country_1 = Country.new(@country_1_details)

    # @country_1.save()

  end

  def test_country_name
    assert_equal("Scotland",@country_1.name)
  end

  def test_country_save_id
    country_1 = Country.find(1)
    assert_equal(1,country_1.id)
  end

  def test_country_find_all
    # Country.delete(1)
    assert_equal(4,Country.find_all.count)

  end

  # def test_country_delete
  #   Country.delete(1)
  #   assert_equal(3,Country.find_all.count)
  # end

end
