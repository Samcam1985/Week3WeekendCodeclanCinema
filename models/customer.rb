require_relative("../db/sql_runner")

class Customer

attr_reader :id
attr_accessor :name, :funds

def initialize(options)
  @id = options['id'].to_i
  @name = options['name']
  @funds = options['funds'].to_i
end

def save()
  sql = "INSERT INTO customers (name, funds)
  VALUES ('#{@name}', '#{@funds}') RETURNING id"
  customer = SqlRunner.run(sql).first
  @id = customer['id'].to_i
end

def Customer.all()
  sql = "SELECT * FROM customers"
  return SqlRunner.run(sql)
end


def Customer.delete_all() 
  sql = "DELETE FROM customers"
  SqlRunner.run(sql)
end

def update()
  sql = "UPDATE customers SET (name, funds) = ('#{@name}', #{funds}) WHERE id = #{id}"
  customers = SqlRunner.run(sql)
  return customers.map{|customer| Customer.new(customer)} 
end

def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = #{@id}"
    return Customer.map_items(sql)
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets
    INNER JOIN customers
    ON customers.id = tickets.customer_id
    WHERE customers.id = #{@id}"
    return Ticket.map_items(sql)

  end

  
  def self.map_items(sql)
   customer_hashes = SqlRunner.run(sql)
   result = customer_hashes.map {|customer_hash| Customer.new(customer_hash)}
   return result
end
end
