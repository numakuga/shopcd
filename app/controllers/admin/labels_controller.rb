class Admin::LabelsController < ApplicationController
  def index
    @new_label = Label.new
    @labels = Label.all
  end

  def create
    # binding.pry
    new_label = Label.new(label_params)
    if new_label.save
      flash[:notice] = "レーベルを作成しました"
      redirect_to admin_labels_path
    else
      render "index"
    end
  end

  def update
  end

  def destroy
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end
end
