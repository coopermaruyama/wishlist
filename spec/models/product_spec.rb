require 'spec_helper'

describe Product do

  before(:each) {@product = Factory(:product)}

  describe 'should create an instance given valid attributes' do

    Product.create!(Factory.attributes_for(:product))

  end

  describe 'validations' do

    it {should validate_presence_of(:name)}

    it {should validate_presence_of(:price)}

    it {should ensure_length_of(:name).is_at_least(2).is_at_most(80)}

    it 'should only accept decimal price values' do
      product = Product.create(Factory.attributes_for(:product, price: 99))
      product.should_not be_valid

      product = Product.create(Factory.attributes_for(:product, price: 49.99))
      product.should be_valid
    end

    it 'should only accept integer values for price'

    it {should ensure_length_of(:description).is_at_most(5000)}

  end

end
