require 'rspec'
require 'Author'
require 'Book'
require 'Checkout'
require 'Patron'
require 'pry'
require 'pg'
require 'spec_helper'

describe ('Patron') do
  describe ('#==') do
    it('2 patrons are the same if they have the same name') do
      patron1 = Patron.new({:name => "Jane Smith", :id => nil})
      patron2 = Patron.new({:name => "Jane Smith", :id => nil})
      patron1.save
      patron2.save
      expect(patron1).to(eq(patron2))
    end
  end
end
