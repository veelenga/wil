module FunWithStrings
  ##############################################################################
  # Returns true if and only if its receiver is a palindrome
  ##############################################################################
  def palindrome?
    g = self.downcase.gsub /[^a-z0-9]+/i, ''
    g == g.reverse
  end

  ##############################################################################
  # Given an input string, return a hash whose keys are words in the string and 
  # whose values are the number of times each word appears:
  #      "To be or not to be" # => {"to"=>2, "be"=>2, "or"=>1, "not"=>1}
  ##############################################################################
  def count_words
    h = Hash.new(0)
    g = self.downcase.gsub /[^a-z0-9 ]+/i, ''
    g.split.each { |x| h[x] = h[x] + 1 }
    h
  end


  ##############################################################################
  # Given a space separated list of words in a single string, write a method 
  # that groups them into anagram groups and returns the array of groups. Case 
  # doesn't matter in classifying string as anagrams (but case should be 
  # preserved in the output), and the order of the anagrams in the groups 
  # doesn't matter.
  ##############################################################################
  def anagram_groups
    g = self.downcase.split.group_by{ |x| x.chars.sort }.values
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end

#p 'A man, a plan, a canal -- Panama'.palindrome?
#p 'Doo bee doo bee doo'.count_words
#p 'scream cars for four scar creams'.anagram_groups
