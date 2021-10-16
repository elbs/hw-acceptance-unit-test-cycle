# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    # Elba: I could have done something like: m = Movie.new and then
    # done m.title = movie['title'], m.rating = movie['rating'], etc.
    # Ending with m.save!
    # See: https://guides.rubyonrails.org/active_record_basics.html
    Movie.create movie
  end
  #fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  expect(Movie.count).to eq n_seeds.to_i
end

# Elba: Define "should see" relative to director
# Both movie and director should be in page body
When /the director of "(.*)" should be "(.*)"/ do |m1, d2|
  expect(Movie.find_by(title: m1).director).to eq(d2)
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  HINT: page.body is the entire content of the page as a string.
  pattern = /#{e1}.+#{e2}/m
  expect(page.body).to match(pattern)
  #fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # Elba: used HINT and split up the ratings, using web_steps.rb lines 90 & 94!
  token_ratings = rating_list.split(',')
  token_ratings.each do |rating|
    if uncheck
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
  #fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #grab count of movies. Should this be n_seeds.to_i instead? Hmm
  movie_count = Movie.count
  # Call the step we already made in line #16, easy!
  step "#{movie_count} seed movies should exist" 
  #fail "Unimplemented"
end
