class Movie < ActiveRecord::Base
  has_many :ratings
  def Movie.get_ratings
    {"G"=>1, "PG"=>1, "PG-13"=>1, "R"=>1}
    #["G", "PG", "PG-13", "R"]
  end
end
