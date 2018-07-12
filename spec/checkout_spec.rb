require 'rspec'
require 'Author'
require 'Book'
require 'Checkout'
require 'Patron'
require 'pry'
require 'pg'
require 'spec_helper'


describe('Checkout') do
  describe('#initialize') do
    it('will test the date methods') do
      new_checkout = Checkout.new({:book_id => 1, :patron_id => 1, :checkout_date => Date.new(2018, 06, 15), :id => nil})
      expect(new_checkout.due_date).to(eq(Date.today))
    end
  end
  describe("#==") do
    it("are checkout instances the same") do
      checkout1 = Checkout.new({:book_id => 3, :patron_id => 45, :id => nil, :checkout_date => Date.new(2018, 06, 14)})
      checkout2 = Checkout.new({:book_id => 3, :patron_id => 45, :id => nil, :checkout_date => Date.new(2018, 06, 14)})
      checkout1.save
      checkout2.save
      expect(checkout1).to(eq(checkout2))
    end
  end

  describe('#save') do
    it("will create a new checkout then change the book's in_stock status") do
      book1 = Book.new({:title => "Clifford the Big Red Dog", :author => 'John Smith', :id => nil})
      book1.save
      patron1 = Patron.new({:name => "Jane Smith", :id => nil})
      patron1.save
      checkout1 = Checkout.new({:book_id => book1.id, :patron_id => patron1.id, :id => nil, :checkout_date => Date.new(2018, 06, 14)})
      checkout1.save
      in_stock = book1.in_stock?
      book1.update({:title => '', :author => '', :in_stock => in_stock})
      expect(book1.in_stock).to(eq(false))
    end
  end
end
