require 'rspec'
require 'Author'
require 'Book'
require 'Checkout'
require 'Patron'
require 'pry'
require 'pg'
require 'spec_helper'

describe(Book) do
  describe("#==") do
    it("1 is the same book if it has the same title") do
      book1 = Book.new({:title => "Clifford the Big Red Dog", :author => 'John Smith', :id => nil})
      book2 = Book.new({:title => "Clifford the Big Red Dog", :author => 'John Smith', :id => nil})
      book1.save
      book2.save
      expect(book1).to(eq(book2))
    end
  end
end
