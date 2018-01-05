class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    puts "here is the output"
    puts session[:sort]
    sess = session[:sort]
    sort = params[:sort]
    order = nil

    if sort == 'title' || sess == 'title'
      @title_header = 'hilite'
    end
    if sort == 'release_date' || sess == 'title'
      @date_header = 'hilite'
    end

    @movies = Movie.order(sort)
    @all_ratings = Movie.ratings

    if params[:ratings].present?
      session[:filtered_ratings] = params[:ratings]
      @movies = Movie.where(:rating => session[:filtered_ratings].keys)
    end





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

end
