module FunWithStrings
  def palindrome?
    self.downcase.gsub(/[^a-z]/, '') == self.downcase.gsub(/[^a-z]/, '').reverse
  end
  def count_words
    words = Hash.new(0)
    self.downcase.gsub(/[^a-z\s]/,'').split.each do |s|
      words[s] += 1
    end
    words
  end
  def anagram_groups
    self.split.group_by do |x|
      x.downcase.chars.sort
    end.values
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
