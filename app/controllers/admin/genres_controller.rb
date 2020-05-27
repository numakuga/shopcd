class Admin::GenresController < Admin::AdminapplicationsController
  def index
    @new_genre = Genre.new
    @genres = Genre.all
  end

  def edit
    @edit_model = Genre.find(params[:id])
    @model_name = "ジャンル"
    render 'admin/shared/edit'
  end

  def create
    @new_genre = Genre.new(genre_params)
    if @new_genre.save
      flash[:notice] = 'ジャンルを作成しました'
      redirect_to admin_genres_path
    else
      # @new_genre = Genre.new
      @genres = Genre.all
      render 'index'
    end
  end

  def update
    @edit_model = Genre.find(params[:id])
    if @edit_model.update(genre_params)
      flash[:notice] = "ジャンルを編集しました！"
      redirect_to admin_genres_path
    else
      render ??
    end
  end

  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    flash[:notice] = "ジャンルを削除しました"
    # redirect_to のときはpath名を指定
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
