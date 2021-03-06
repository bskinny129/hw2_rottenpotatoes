class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

	redirect_needed = false
  
    @sort = params[:sort]
	if @sort.nil?
		@sort = session[:sort]
		if !@sort.nil?
			redirect_needed = true
		end
	else
		session[:sort] = @sort.to_s
	end
	
	@all_ratings = Movie.all_ratings
	
	#have to change so that the search respects the ratings
	@ratings = params[:ratings]
	if @ratings.nil?
		if session[:ratings].nil?
			@ratings = []
		else
			@ratings = session[:ratings].keys
			redirect_needed = true
		end
	else
		session[:ratings] = params[:ratings]
		@ratings = params[:ratings].keys
	end
	
	if redirect_needed
		flash.keep
		redirect_to movies_path(:sort => session[:sort], :ratings => session[:ratings] )
	end
	
	@movies = Movie.find(:all, :order => @sort.to_s, :conditions => { :rating => @ratings } )
	
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
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
    redirect_to movies_path
  end

end
