require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests here
    before do 
      @category = Category.new(:name => "Appliances")
      @product = Product.new(:name => "Fridge", :price_cents => 1000000, :quantity => 10, :category => @category)
    end

    it "must have a name to be valid" do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end

    it "must have a price to be valid" do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages.to_sentence).to include("Price cents is not a number, Price is not a number, and Price can't be blank")
    end

    it "must have a quantity to be valid" do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end

    it "must have a category to be valid" do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
    
  end
end
