# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body =~ /#{e1}.*#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(",").each do |s|
    s = s.strip
    if uncheck == "un"
      step %Q{I uncheck "ratings_#{s}"}
      step %Q{the "ratings_#{s}" checkbox should not be checked}
    else
      step %Q{I check "ratings_#{s}"}
      step %Q{the "ratings_#{s}" checkbox should be checked}
    end
  end
end

Then /^I should(n't)? see: (.*)/ do |neg, title_lst|
  title_lst.split(", ").each do |title|
    assert page.has_content?(title) == false if neg
    assert page.has_content?(title) unless neg
  end
end

When /^I press (.*)$/ do |pressed|
        click_button(pressed)
end

Then /I should see all the movies/ do
  Movie.all.each do |m|
    step %Q{I should see "#{m.title}"}
  end
end

Then /I shouldn't see any movies/ do
  Movie.all.each do |m|
    step %Q{I shouldn't see: "#{m.title}"}
  end
end

