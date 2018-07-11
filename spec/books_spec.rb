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

  describe('#update') do
    it('will update the title and author of the book') do
      book1 = Book.new({:title => "Clifford the Big Red Dog", :author => 'John Smith', :id => nil})
      book1.save
      book1.update({:title => 'Clifford the Big Red Dog', :author => 'Norman Bridwell'})
      expect(book1.author).to(eq('Norman Bridwell'))
    end
  end

  describe('#delete')do
    it("lets you delete a book from the books table") do
      book1 = Book.new({:title => "Clifford the Big Red Dog", :author => 'Norman Bridwell', :id => nil})
      book1.save
      book2 = Book.new({:title => "Internet for Dummys", :author => 'Someguy', :id => nil})
      book2.save
      book1.delete
      expect(Book.all()).to(eq([book2]))


    end
  end

end
