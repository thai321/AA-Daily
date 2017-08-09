require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef", :name => "thai") }
  subject(:summer) { Dessert.new("summer", 50, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(summer.type).to eq("summer")
    end

    it "sets a quantity" do
      expect(summer.quantity).to eq(50)
    end

    it "starts ingredients as an empty array" do
      expect(summer.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new("five") }.to raise_error
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      summer.add_ingredient("chocolate")
      expect(summer.ingredients.length).to eq(1)
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["vallila", "chocolate", "strawberry", "milk", "bread"]
      ingredients.each { |item| summer.add_ingredient(item) }
      expect(summer.mix!).not_to eq(ingredients)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      summer.eat(15)
      expect(summer.quantity).to eq(35)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { summer.eat(55) }.to raise_error(RuntimeError)
      expect { summer.eat(55) }.to raise_error("not enough left!")
      expect { summer.eat(55) }.to raise_error(RuntimeError, "not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Thai the Great Baker")

      expect(summer.serve).to match(/Chef Thai the Great Baker has /)
      expect(summer.serve).to eq("Chef Thai the Great Baker has made 50 summers!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(summer)
      summer.make_more
    end
  end
end
