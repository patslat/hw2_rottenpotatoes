class Movie < ActiveRecord::Base
  has_many :ratings
  def Movie.get_ratings
    ["G", "PG", "PG-13", "R"]
  end
end
