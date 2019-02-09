class Bucket_List

  attr_reader :id, :city_id, :visited

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @visited = options['visited']
    @city_id = options['city_id']
  end

  def save
    sql = "INSERT INTO bucket_lists(visited,city_id)VALUES($1,$2) RETURNING id"
    values = [@visited,@city_id]
    @id = SqlRunner.run(sql,values)[0]['id']
  end

  def update
    sql = "UPDATE bucket_lists SET (visited,city_id)=($1,$2) WHERE id = $3"
    values = [@visited,@city_id,@id]
    SqlRunner.run(sql,values)
  end

  def self.delete(id)
    sql = "DELETE * FROM bucket_lists WHERE id = $1"
    values = [id]
    SqlRunner.run(sql,values)
  end

  def self.delete_all
    sql = "DELETE FROM bucket_lists"
    values = []
    SqlRunner.run(sql,values)
  end

  def self.find(id)
    sql = "SELECT * FROM bucket_lists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values)[0]
    return Bucket_List.new(result)
  end

  def self.find_all
    sql = "SELECT * FROM bucket_lists"
    values = []
    result = SqlRunner.run(sql,values)
    return result.map {|bucket_list| Bucket_List.new(bucket_list)}
  end

end
