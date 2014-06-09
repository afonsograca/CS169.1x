require 'spec_helper'

describe MoviesController do
  describe 'show movie' do
    before :each do 
      @m=mock(Movie, :title => "Star Wars", :director => "George Lucas", :id => "1")
    end
    it 'should generate routing for Show Movie' do
      { :get => movie_path(1) }.
      should route_to(:controller => "movies", :action => "show", :id => "1")
    end
    it 'should call the method that shows the movie' do
      Movie.should_receive(:find).with('1')
      get :show, {:id => "1"}
    end
    it 'should select the Show Movie template for rendering' do
      Movie.stub(:find).with('1')
      get :show, :id => 1
      response.should render_template('show')
    end
  end
  
  describe 'index movies' do
    before :each do 
      @m=mock(Movie, :title => "Star Wars", :director => "George Lucas", :id => "1")
      fake_results = [mock('Movie1'), mock('Movie2')]
    end
    it 'should generate routing for Show Movie' do
      { :get => movies_path }.
      should route_to(:controller => "movies", :action => "index")
    end
    it 'should call the method that finds all the movies' do
      Movie.should_receive(:find_all_by_rating).with(["G", "PG", "PG-13", "NC-17", "R"],nil)
      get :index
    end
    it 'should call the method that finds the movies with sort by title' do
      Movie.stub(:find_all_by_rating).with(["G", "PG", "PG-13", "NC-17", "R"],{:order => :title})
      get :index, {:sort => 'title'}
    end
    it 'should call the method that finds the movies with sort by release date' do
      Movie.stub(:find_all_by_rating).with(["G", "PG", "PG-13", "NC-17", "R"], :order => :release_date)
      get :index, {:sort => 'release_date'}
    end
    it 'should select the Show Movie template for rendering' do
      Movie.stub(:find_all_by_rating).with(["G", "PG", "PG-13", "NC-17", "R"],nil)
      get :index
      response.should render_template('index')
    end
  end
  
  describe 'edit movie' do
    before :each do 
      m=mock(Movie, :title => "Star Wars", :director => "George Lucas", :id => "1")
    end
    it 'should generate routing for Edit Movie' do
      { :get => edit_movie_path(1) }.
      should route_to(:controller => "movies", :action => "edit", :id => "1")
    end
    it 'should call the method that edits the movie' do
      Movie.should_receive(:find).with('1')
      get :edit, {:id => "1"}
    end
    it 'should select the Show Movie template for rendering' do
      Movie.stub(:find).with('1')
      get :edit, :id => 1
      response.should render_template('edit')
    end
  end
  
  describe 'add director' do
    before :each do
      @movie=mock(Movie, :title => "Star Wars", :director => "director", :id => "1")
      Movie.stub!(:find).with("1").and_return(@movie)
    end
    it 'should call update_attributes and redirect' do
      @movie.stub!(:update_attributes!).and_return(true)
      put :update, {:id => "1", :movie => @movie}
      response.should redirect_to(movie_path(@movie))
    end
  end
  
  describe 'happy path' do
    before :each do
      @movie=mock(Movie, :title => "Star Wars", :director => "director", :id => "1")
      Movie.stub(:find_by_id).with("1").and_return(@movie)
    end
  
    it 'should generate routing for Find Movies by Director' do
      { :get => movie_by_director_path(1) }.
      should route_to(:controller => "movies", :action => "by_director", :movie_id => "1")
    end
    it 'should call the method that finds movies by director' do
      fake_results = [mock('Movie1'), mock('Movie2')]
      Movie.should_receive(:find_all_by_director).with('director').and_return(fake_results)
      get :by_director, {:movie_id => "1"}
    end
    it 'should select the Find Director template for rendering' do
      fake_results = [mock('Movie1'), mock('Movie2')]
      Movie.stub(:find_all_by_director).with('director').and_return(fake_results)
      get :by_director, :movie_id => 1
      response.should render_template('by_director')
    end
    it 'should make results available' do
      fake_results = [mock('Movie1'), mock('Movie2')]
      Movie.should_receive(:find_all_by_director).with('director').and_return(fake_results)
      get :by_director, :movie_id => 1
      assigns(:movies).should == fake_results
    end
  end
  
  describe 'sad path' do
    before :each do
      m=mock(Movie, :title => "Star Wars", :director => nil, :id => "1")
      Movie.stub(:find_by_id).with("1").and_return(m)
    end
  
    it 'should generate routing for Find Movies by Director' do
      { :get => movie_by_director_path(1) }.
      should route_to(:controller => "movies", :action => "by_director", :movie_id => "1")
    end
    it 'should select the Index template for rendering and generate a flash' do
      Movie.stub(:find_all_by_director)
      get :by_director, :movie_id => 1
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end
  
  describe 'create and destroy'  do
    it 'should create a new movie' do
      MoviesController.stub(:create).and_return(mock('Movie'))
      post :create, {:id => "1"}
    end
    it 'should destroy a movie' do
      m = mock(Movie, :id => "10", :title => "blah", :director => nil)
      Movie.stub!(:find).with("10").and_return(m)
      m.should_receive(:destroy)
      delete :destroy, {:id => "10"}
    end
  end
end