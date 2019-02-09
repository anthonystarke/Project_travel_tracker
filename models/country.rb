require_relative("../db/sql_runner")

class Country

  attr_reader :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO countries(name)VALUES($1)RETURNING id"
    values = [@name]
    @id = SqlRunner.run(sql,values)[0]['id']
  end

  def self.find_all
    sql = "SELECT * FROM countries"
    values = []
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM countries WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values)[0]
    return Country.new(result)
  end

  def self.delete(id)
    sql = "DELETE FROM countries WHERE id = $1"
    values = [id]
    SqlRunner.run(sql,values)
  end

  def self.delete_all
    sql = "DELETE FROM countries"
    values = []
    SqlRunner.run(sql,values)
  end

end