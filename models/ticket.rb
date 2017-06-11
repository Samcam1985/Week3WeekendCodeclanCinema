require_relative("../db/sql_runner")

class Ticket

attr_reader :id
attr_accessor :customer_id, :film_id

def initialize(options)
  @id = options['id'].to_i
  @customer_id = options['customer_id'].to_i
  @film_id = options['film_id'].to_i
end

def save()
  sql = "INSERT INTO tickets (customer_id, film_id)
  VALUES ('#{@customer_id}', '#{@film_id}') RETURNING id"
  ticket = SqlRunner.run(sql).first
  @id = ticket['id'].to_i
end

def Ticket.all()
  sql = "SELECT * FROM tickets"
  return SqlRunner.run(sql)
end

def Ticket.all()
  sql = "SELECT * FROM tickets"
  return Ticket.map_items(sql)
end

def Ticket.delete_all() 
  sql = "DELETE FROM tickets"
  SqlRunner.run(sql)
end

def update()
  sql = "UPDATE tickets SET (customer_id, film_id) = (#{@customer_id}, #{film_id}) WHERE id = #{id}"
  tickets = SqlRunner.run(sql)
  return tickets.map{|ticket| Ticket.new(ticket)} 
end


def self.map_items(sql)
 ticket_hashes = SqlRunner.run(sql)
 result = ticket_hashes.map {|ticket_hash| Ticket.new(ticket_hash)}
 return result
end
end
