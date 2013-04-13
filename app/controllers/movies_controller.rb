class MoviesController < ApplicationController
  helper_method :sort_by

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @all_ratings = Movie.get_ratings.keys
    
    if sort_by && params[:ratings]
      @sort_by = sort_by
      session[:sort] = sort_by
      @rating_filter = params[:ratings].keys
      session[:ratings] = params[:ratings]
    elsif sort_by && !params[:ratings]
      if session[:ratings]
        redirect_to({:sort => params[:sort], :ratings => session[:ratings]})
      else
        redirect_to({:sort => params[:sort], :ratings => @all_ratings})
      end
    elsif !sort_by && params[:ratings]
      if session[:sort]
        redirect_to({:sort => session[:sort], :ratings => params[:ratings]})
      else
        redirect_to({:sort => nil, :ratings => params[:ratings]})
      end
    else
      if session[:sort] && session[:ratings]
        redirect_to({:sort => session[:sort], :ratings => session[:ratings]})
      elsif session[:sort] && !session[:ratings]
        redirect_to({:sort => session[:sort], :ratings => @all_ratings})
      elsif !session[:sort] && session[:ratings]
        redirect_to({:sort => nil, :ratings => session[:ratings]})
      else
        redirect_to({:sort => nil, :ratings => @all_ratings})
      end
    end

    @movies = Movie.where(:rating => @rating_filter).order(@sort_by)

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

  private

  def sort_by
    Movie.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

end
