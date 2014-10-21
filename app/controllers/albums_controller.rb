class AlbumsController < ApplicationController
  before_filter :set_album, only: [:show, :edit, :update, :delete]

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to @album, notice: "Album was successfully created."
    else
      render :new
    end
  end

  def show
  end

  def edit
    # @album = Album.find(album_params)
  end

  def update
    if @album.update(album_params)
      redirect_to @album, notice: "Album was successfully updated."
    else
      render :edit
  end
end

def delete
  @album.destroy
end

private

def set_album
  @album = Album.find(params[:id])
end


def album_params
  params.require(:album).permit(:title, :artist, :year)
end


end
