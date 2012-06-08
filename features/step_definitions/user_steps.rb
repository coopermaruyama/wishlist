Given /^I am not logged in$/ do
  visit(sign_out_path)
end

Then /^I should be signed in$/ do
  visit(root_path)
end
