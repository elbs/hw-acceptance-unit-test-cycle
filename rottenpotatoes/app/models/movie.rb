class Movie < ActiveRecord::Base
  # Elba: I think this will solve issues of no director, to boot.
  # Hint: Or you could define it as a class method,
  # e.g. Movie.with_director(director). In fact,
  # it's great practice to write it both ways. Took latter.
  def self.with_director(dir)
    where(director: dir)
  end

  # Elba: Copy from HW3
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
end
