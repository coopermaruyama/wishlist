require 'faker'

FactoryGirl.define do

  factory :user do
    first_name            {Faker::Name.first_name}
    last_name             {Faker::Name.last_name}
    email                 {Faker::Internet.email}
    password              'foobar69'
    password_confirmation 'foobar69'
  end

  factory :product do
    name         {Faker::Name.first_name}
    price        29.99
    description  {Faker::Lorem.paragraphs(3).join(' ')}
    brand        {Faker::Lorem.words(1).join(' ')}
    hero_img_url 'http://www.coffeemakersetc.com/images/bunn-bx-b.jpg'
    source       'internal'
  end

end
