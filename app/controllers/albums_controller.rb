class AlbumsController < ApplicationController
  def index
    @albums = Album.all
  end

  def new(title, artist, year)
    @album = Album.new
  end

  def create
    @album = Album.new(post_params)
  end


end
