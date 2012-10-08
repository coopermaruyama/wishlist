class LineItem < ActiveRecord::Base
  attr_accessible :list_id, :product_id
  belongs_to :product
  belongs_to :list

  # require "capybara"
  # require "capybara/dsl"
  # require "capybara-webkit"
  # include Capybara::DSL

  # def amazonPurchase
  # 	Capybara.run_server = false
  #   Capybara.current_driver = :selenium
  #   Capybara.reset_sessions!

  #   #Page 1 (Confirm add to cart)
  #   visit("http://www.amazon.com/gp/aws/cart/add.html?ASIN.1=#{self.product_id}&Quantity.1=1&AWSAccessKeyId=#{ENV['AWS_ACCESS_KEY_ID']}&AssociateTag=#{ENV['ASSOCIATE_TAG']}")
  #   Capybara.click_button('Continue')

  #   #Page 2 (View/Update Cart)
  #   Capybara.find(:xpath, "//form[@name='cartViewForm']").find(:xpath, ".//input[@type='checkbox']").click
  #   Capybara.find_button('Proceed to Checkout').click

  #   #Page 3 (Sign In)
  #   Capybara.fill_in('email', :with => 'baronmurdock@gmail.com')
  #   Capybara.fill_in('password', :with => 'smlove23')
  #   Capybara.find(:xpath, "//form[@name='signIn']//input[@id='signInSubmit']").click

  #   #Page 4 (Shipping)
  #   Capybara.fill_in('enterAddressFullName', :with => 'Baron Murdock')
  #   Capybara.fill_in('enterAddressAddressLine1', :with => '9352 Venice Blvd')
  #   Capybara.fill_in('enterAddressAddressLine2', :with => '')
  #   Capybara.fill_in('enterAddressCity', :with => 'Culver City')
  #   Capybara.fill_in('enterAddressStateOrRegion', :with => 'CA')
  #   Capybara.fill_in('enterAddressPostalCode', :with => '90232')
  #   Capybara.fill_in('enterAddressPhoneNumber', :with => '3109516504')
  #   Capybara.find(:xpath, "//form//div[@id='newshippingactions']//input[@name='shipToThisAddress']").click

  #   #Page 5 (Gift Options)
  #   Capybara.find(:xpath, "//form//div[@class='giftWrapRadio']//input[@type='radio' and @class='itemGiftWrapSelect']").click
  #   Capybara.find(:xpath, "//div[@class='giftSelectItemRight']//textarea[contains(@id, 'message')]").set('testing') # gift note!
  #   Capybara.click_button('Continue')

  #   #Page 6 (Shipping Options)
  #   Capybara.click_button('set shipping option')

  #   #Page 7 (Payment)
  #   sleep(5)
  #   Capybara.find(:xpath, "//tbody[@id='existing-credit-cards']//input[@type='radio']").click
  #   # if Capybara.page.has_content?('Please re-enter your card number')
  #   #   Capybara.find(:xpath, "//tbody[@id='existing-credit-cards']//input[@class='validate' and @type='text']").set('4427427031164223')
  #   #   Capybara.find(:xpath, "//tbody[@id='existing-credit-cards']//input[@alt='Confirm Card' and @type='image']").click
  #   # end
  #   Capybara.click_button('Continue')
  #   # Capybara.click_button('Place Your Order')
  #   #Complete!
  # end
end
