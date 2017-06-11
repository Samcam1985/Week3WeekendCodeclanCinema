require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

require('pry-byebug')

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({ 'name' => 'Sam', 'funds' => 30 })
customer1.save()

customer2 = Customer.new({ 'name' => 'Sarah', 'funds' => 25 })
customer2.save()

film1 = Film.new({ 'title' => 'Wonder Woman', 'price' => 9 })
film1.save()

film2 = Film.new({ 'title' => 'Pirates of the Caribbean: Salazars Revenge', 'price' => 10})
film2.save()

ticket1 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id })
ticket1.save

ticket2 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id })
ticket2.save

ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket3.save

binding.pry
nil