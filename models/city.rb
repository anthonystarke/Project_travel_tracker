require_relative('../models/country')
require_relative('../db/sql_runner')

class City

  attr_reader :id, :country_id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @country_id = options['country_id'].to_i
  end

  def country
    return Country.find(country_id)
  end

  def update
    sql = "UPDATE cities SET name = $1 WHERE id = $2"
    values = [@name,@id]
    SqlRunner.run(sql,values)
  end

  def save
    sql = "INSERT INTO cities(name,country_id)VALUES($1,$2) RETURNING id"
    values = [@name,@country_id]
    @id = SqlRunner.run(sql,values)[0]['id']
  end

  def self.delete(id)
    sql = "DELETE FROM cities WHERE id = $1"
    values = [id]
    SqlRunner.run(sql,values)
  end

  def self.delete_all
    sql = "DELETE FROM cities"
    values = []
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM cities WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values)[0]
    return City.new(result)
  end

  def self.find_by_name_count(name)
    sql = "SELECT * FROM cities WHERE name = $1"
    values = [name]
    begin
      result = SqlRunner.run(sql,values)[0]
      return result.count
    rescue
      return 0
    end
  end

  def self.find_all
    sql = "SELECT * FROM cities"
    values = []
    result = SqlRunner.run(sql,values)
    return result.map{|city| City.new(city)}
  end

end
