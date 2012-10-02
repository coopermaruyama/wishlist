module ApplicationHelper
	

	def screenshot
	  require 'capybara/util/save_and_open_page'
	  now = Time.now
	  p = "public/#{now.strftime('%Y-%m-%d-%H-%M-%S')}-#{rand}"
	  Capybara.save_page body, "#{p}.html"
	  path = Rails.root.join("#{Capybara.save_and_open_page_path}" "#{p}.png").to_s
	  page.driver.render path
	  Launchy.open path
	end

	def capy
		Capybara.run_server = false
		Capybara.current_driver = :selenium
		Capybara.reset_sessions!

		#Page 1 (Confirm add to cart)
		visit("http://www.amazon.com/gp/aws/cart/add.html?ASIN.1=B0002YIQEQ&Quantity.1=1&AWSAccessKeyId=AKIAJM45QASRXWCIOU6A&AssociateTag=sho095-20")
		Capybara.click_button('Continue')

		#Page 2 (View/Update Cart)
		Capybara.find(:xpath, "//form[@name='cartViewForm']").find(:xpath, ".//input[@type='checkbox']").click
		Capybara.find_button('Proceed to Checkout').click

		#Page 3 (Sign In)
		Capybara.fill_in('email', :with => 'baronmurdock@gmail.com')
		Capybara.fill_in('password', :with => 'smlove23')
		Capybara.find(:xpath, "//form[@name='signIn']//input[@id='signInSubmit']").click

		#Page 4 (Shipping)
		Capybara.fill_in('enterAddressFullName', :with => 'Baron Murdock')
		Capybara.fill_in('enterAddressAddressLine1', :with => '9352 Venice Blvd')
		Capybara.fill_in('enterAddressAddressLine2', :with => '')
		Capybara.fill_in('enterAddressCity', :with => 'Culver City')
		Capybara.fill_in('enterAddressStateOrRegion', :with => 'CA')
		Capybara.fill_in('enterAddressPostalCode', :with => '90232')
		Capybara.fill_in('enterAddressPhoneNumber', :with => '3109516504')
		Capybara.find(:xpath, "//form//div[@id='newshippingactions']//input[@name='shipToThisAddress']").click

		#Page 5 (Gift Options)
		Capybara.find(:xpath, "//form//div[@class='giftWrapRadio']//input[@type='radio' and @class='itemGiftWrapSelect']").click
		Capybara.find(:xpath, "//div[@class='giftSelectItemRight']//textarea[contains(@id, 'message')]").set('testing') # gift note!
		Capybara.click_button('Continue')

		#Page 6 (Shipping Options)
		Capybara.click_button('set shipping option')

		#Page 7 (Payment)
		sleep(5)
		Capybara.find(:xpath, "//tbody[@id='existing-credit-cards']//input[@type='radio']").click
		if Capybara.page.has_content?('Please re-enter your card number')
			Capybara.find(:xpath, "//tbody[@id='existing-credit-cards']//input[@class='validate' and @type='text']").set('4427427031164223')
			Capybara.find(:xpath, "//tbody[@id='existing-credit-cards']//input[@alt='Confirm Card' and @type='image']").click
		end
		Capybara.click_button('Continue')
		Capybara.click_button('Place Your Order')
		#Complete!
	end

	def mechanize
  	#url http://www.amazon.com/gp/aws/cart/add.html?ASIN.1=B0002YIQEQ&Quantity.1=1&AWSAccessKeyId=AKIAJM45QASRXWCIOU6A&AssociateTag=sho095-20
  	agent = Mechanize.new
    agent.cookie_jar.clear! #clear cookies
  	#TODO: Clear cart in case we have items already in cart

  	#Page 1 (Confirm add to cart)
  	page1 = agent.get("http://www.amazon.com/gp/aws/cart/add.html?ASIN.1=B0002YIQEQ&Quantity.1=1&AWSAccessKeyId=AKIAJM45QASRXWCIOU6A&AssociateTag=sho095-20")
  	form = page1.forms[1]
  	button = form.buttons.first
  	page2 = agent.submit(form,button)
  	#Page 2 (view/update cart)
    agent.page.form('cartViewForm').checkboxes.first.check 
  	form2 = agent.page.form('cartViewForm')
  	form2.checkbox.check
  	checkoutForm = page2.form_with(:id => "gutterCartViewForm")
  	checkoutBtn = checkoutForm.buttons.last
  	page3 = agent.submit(checkoutForm, checkoutBtn)
  	#page3 (Sign in)
  	form3 = page3.form('signIn')
  	form3.email = 'baronmurdock@gmail.com'
  	form3.password = 'smlove23'
  	page4 = agent.submit(form3, form3.buttons.last)
  	#page4 (Where do you want your items shipped?)
  	form4 = agent.page.form_with(:action => "/gp/buy/shipaddressselect/handlers/continue.html/ref=ox_shipaddress_add_new_addr")
  	form4.enterAddressFullName = 'Baron Murdock'
  	form4.enterAddressAddressLine1 = '9352 Venice Blvd'
  	form4.enterAddressAddressLine2 = ''
  	form4.enterAddressCity = 'Culver City'
  	form4.enterAddressStateOrRegion = 'CA'
  	form4.enterAddressPostalCode = '90232'
  	form4.enterAddressPhoneNumber = '3109516504'
  	page5 = agent.submit(form4, form4.buttons.last)
  	#page5 (Choose your shipping options)
    agent.page.form_with(:id => "shippingOptionFormId").checkboxes.last.check
    agent.page.form_with(:id => "shippingOptionFormId").submit
    #page 6 (gift wrapping form)
    agent.page.form_with(:id => "GiftPageContiueForm").radiobuttons_with(:class => "itemGiftWrapSelect").each do |t|
      t.check
    end
    agent.page.form_with(:id => "GiftPageContiueForm").submit
    #page7
    agent.page.forms.each do |t|
      if t.button_with(:id => "continue-top")
        form = t
        button = t.button_with(:id => "continue-top")
      end
    end
    agent.submit(form,button)
  	return agent.page.uri.to_s
  end
end
