class MoviesController < ApplicationController
  def index
    @movies = Movie.where(nil)
    @movies = @movies.with_title(params[:title]) if params[:title].present?
    @movies = @movies.with_director(params[:director]) if params[:director].present?
    if params[:duration_criteria].present?
puts params[:duration_criteria]
      case params[:duration_criteria].to_sym
      when :less_than_90     then @movies = @movies.with_duration(Range.new(-Float::Infinity, 89))
      when :between_90_120   then @movies = @movies.with_duration(Range.new(90, 120))
      when :greater_than_120 then @movies = @movies.with_duration(Range.new(121, Float::Infinity))
      end
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected
    def movie_params
      params.require(:movie).permit(
        :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :poster_image)
    end
    
end
