Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  p1 = (page.body =~ /#{e1}/)
  p2 = (page.body =~ /#{e2}/)

  assert p1, "Page does not contain #{e1}"
  assert p2, "Page does not contain #{e2}"
  assert p1 < p2, "#{e1} occurs at #{p1}, #{e2} occurs at #{p2}"
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    field = "ratings_#{rating.strip}"
    if uncheck
      uncheck field
    else
      check field
    end
  end
end

Then /I should see all the movies/ do
  movies = Movie.all
  movies.each do |movie|
    assert page.body =~ /#{movie.title}/, "Missing #{movie.title} "
  end
end
