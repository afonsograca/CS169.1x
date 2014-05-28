class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date
  def self.ratings
    Movie.select('DISTINCT rating').map{|x| x.rating}
  end
end
