class Admin::ArtistsController < Admin::AdminapplicationsController
  def index
    @new_artist = Artist.new
    @artists = Artist.all
  end

  def edit
    @edit_model = Artist.find(params[:id])
    @model_name = "アーティスト"
    render 'admin/shared/edit'
  end

  def create
    @new_artist = Artist.new(artist_params)
    if @new_artist.save
      flash[:notice] = "アーティストを作成しました"
      redirect_to admin_artists_path
    else
      # @new_artist = Artist.new
      @artists = Artist.all
      render "index"
    end
  end

  def update
    @edit_artist = Artist.find(params[:id])
    if @edit_artist.update(artist_params)
      flash[:notice] = "アーティストを編集しました！"
      redirect_to admin_artists_path
    else
      render "admin/shared/edit"
    end
  end

  def destroy
    artist = Artist.find(params[:id])
    artist.destroy
    flash[:notice] = "アーティストを削除しました"
    # redirect_to のときはpath名を指定
    redirect_to admin_artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
