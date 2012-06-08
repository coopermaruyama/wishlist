require 'spec_helper'

describe User do

  before(:each) {@user = Factory(:user)}

  it 'should create a new instance given valid attributes' do
    User.create!(Factory.attributes_for(:user))
  end

  describe 'validations' do

    it {should validate_presence_of(:first_name)}

    it {should validate_presence_of(:last_name)}

    it {should ensure_length_of(:first_name).is_at_least(2).is_at_most(25)}

    it {should ensure_length_of(:last_name).is_at_least(2).is_at_most(30)}

  end

end
