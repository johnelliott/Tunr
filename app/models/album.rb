class Album < ActiveRecord::Base
  def index
    unless Album.all = []
      @albums = Album.all
    else
      []
    end
  end
end
