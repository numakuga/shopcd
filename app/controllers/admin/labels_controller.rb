class Admin::LabelsController < Admin::AdminapplicationsController
  before_action :current_admin

  def index
    @new_label = Label.new
    @labels = Label.all
  end

  def edit
    @edit_model = Label.find(params[:id])
    @model_name = "レーベル"
    render 'admin/shared/edit'
  end
  
  def create
    @new_label = Label.new(label_params)
    if @new_label.save
      flash[:notice] = "レーベルを作成しました"
      redirect_to admin_labels_path
    else
      @labels = Label.all
      render 'index'
      # binding.pry
    end
  end

  def update
    @edit_model = Label.find(params[:id])
    if @edit_model.update(label_params)
      flash[:notice] = "レーベルを編集しました！"
      redirect_to admin_labels_path
    else
      render ??
    end
  end

  def destroy
    label = Label.find(params[:id])
    label.destroy
    flash[:notice] = "レーベルを削除しました"
    # redirect_to のときはpath名を指定
    redirect_to admin_labels_path
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
