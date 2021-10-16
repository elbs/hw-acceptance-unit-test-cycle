class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  #Elba: Add function to get all with same director
  def find_with_director

    # First, get director of this movie ID and
    # their portfolio
    @movie = Movie.find(params[:id])
    dir = @movie.director

    # portfolio holds results to print
    @portfolio = Movie.with_director(dir)

    # If director name is empty string, aka not set,
    # be sad and redirect to home page
    if dir.empty? then
      flash[:notice] = "'#{@movie.title}' has no director info"
      redirect_to movies_path
    end

  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  # Elba: Add director here to params
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
