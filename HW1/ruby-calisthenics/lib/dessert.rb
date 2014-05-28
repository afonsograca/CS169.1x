class Dessert
  attr_accessor :name
  attr_accessor :calories
  def initialize(name, calories)
    @name = name
    @calories = calories
  end
  def healthy?
    calories < 200 ? true : false
  end
  def delicious?
    true
  end
end

class JellyBean < Dessert
  attr_accessor :flavor
  def initialize(flavor)
    super(flavor+' jelly bean', 5)
    @flavor = flavor
  end
  
  def delicious?
    @flavor == 'licorice' ? false : true
  end
end
