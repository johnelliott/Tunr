class Album < ActiveRecord::Base
  def index
    @albums = Album.all
  end
end
