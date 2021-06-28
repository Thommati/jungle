require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.new
    @category.name = 'Blankets'
    @category.save

    @product = Product.new
    @product.name = 'Test Product'
    @product.price_cents = 1000
    @product.quantity = 2
    @product.category = @category
  end

  describe 'Validations' do
    it 'saves a new product when all four fields are set' do
      @product.save!
    end

    it "gives 'Name can't be blank' error when name is nil" do
      @product.name = nil
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "gives 'Price cents is not a number' error when price is nil" do
      @product.price_cents = nil
      @product.save

      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end

    it "gives 'Quantity can't be blank' error when quantity is nil" do
      @product.quantity = nil
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "gives 'Category can't be blank' error when category is nil" do
      @product.category = nil
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
