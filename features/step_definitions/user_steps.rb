Given /^I am not logged in$/ do
  visit(sign_out_path)
end

Then /^I should be signed in$/ do
  visit(signed_in_users_path)
end
