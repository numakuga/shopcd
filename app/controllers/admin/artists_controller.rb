class Admin::ArtistsController < ApplicationController
  def index
    @new_artist = Artist.new
  end

  def create
    new_artist = Artist.new(artist_params)
    if new_artist.save
      flash[:notice] = "アーティストを作成しました"
      redirect_to admin_artists_path
    else
      render "index"
    end
  end

  def update
  end

  def destroy
  end

   private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
