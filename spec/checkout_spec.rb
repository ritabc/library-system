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
      new_checkout = Checkout.new({:book_id => 1, :patron_id => 1, :checkout_date => Date.new(2018, 06, 14)})
      expect(new_checkout.due_date).to(eq(Date.today))
    end
  end
end
