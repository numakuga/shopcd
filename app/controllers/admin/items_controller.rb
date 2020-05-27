class Admin::ItemsController < Admin::AdminapplicationsController
  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @new_item = Item.new
    @artists = Artist.all
    @labels = Label.all
    @genres = Genre.all
  end

  def edit
  end

  def create
    @new_item = Item.new(item_params)
    if @new_item.save
      flash[:notice] = "商品情報を作成しました"
      redirect_to admin_item_path(@new_item)
    else
      render "new"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "アーティストを編集しました！"
      redirect_to admin_item_path
    else
      render "admin/shared/edit"
    end
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:title, :price, :status, :jacket_image, :stock, :release, :artist_id, :label_id, :genre_id)
  end

end
