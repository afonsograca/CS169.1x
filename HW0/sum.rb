def sum(numbers)
  numbers.empty? ? 0 : numbers.shift + sum(numbers)
end

def max_2_sum(numbers)
  if numbers.empty?
    0
  elsif numbers.length < 2
    numbers[0]
  else
    numbers.sort!
    numbers.reverse!
    numbers[0] + numbers[1]
  end
end

def sum_to_n?(numbers,n)
  if numbers.empty? || numbers.length < 2
    false
  else
    numbers.combination(2){ |x,y|
      return true if x+y == n
    }
  end
  false
end