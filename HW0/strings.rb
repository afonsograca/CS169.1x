def hello(name)
  'Hello, ' + name
end

def starts_with_consonant?(s)
  if s.empty? 
    false
  else
    s[0] =~ /^[^a-z]$/i || ['A','E','I','O','U'].include?(s[0].upcase) ? false : true
  end
end

=begin
puts starts_with_consonant?('')
puts starts_with_consonant?('Hello')
puts starts_with_consonant?('Afon')
puts starts_with_consonant?('qf')
puts starts_with_consonant?('ag')
puts starts_with_consonant?('24')
=end

def binary_multiple_of_4?(s)
  s =~ /^[01]*00$/ || s =~ /^[0]+$/ ? true : false
end
puts binary_multiple_of_4?('')
puts binary_multiple_of_4?('s')
puts binary_multiple_of_4?('101')
puts binary_multiple_of_4?('0')
puts binary_multiple_of_4?('10100')
puts binary_multiple_of_4?('101001')

