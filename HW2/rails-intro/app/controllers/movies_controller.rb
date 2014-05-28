class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.ratings

    @selected_ratings = params[:ratings] || session[:ratings] 
    @selected_ratings = Hash[@all_ratings.collect {|rating| [rating, 1]}] unless @selected_ratings
    
    @movies = Movie.find(:all, :conditions => {:rating => @selected_ratings.keys}, :order => session[:sort])
      
    case params[:sort]
      when 'title' then @title_header = 'hilite'
      when 'release_date' then  @release_header = 'hilite'
    end
    if session[:ratings] != params[:ratings] || session[:sort] != params[:sort]
      session[:sort] = params[:sort] if params[:sort]
      session[:ratings] = params[:ratings] if params[:ratings]
      redirect_to :sort => session[:sort], :ratings => session[:ratings] and return
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    flash.keep
    redirect_to movies_path, :sort => session[:sort], :ratings => session[:ratings]
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    flash.keep
    redirect_to movies_path :sort => session[:sort], :ratings => session[:ratings]
  end

end
