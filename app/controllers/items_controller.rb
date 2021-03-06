class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :not_exhibitor, only: [:edit, :update]
  
  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params) # updateというActiveRecordメソッドを使用
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @item = Item.destroy(params[:id])
    redirect_to action: :index
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :burden_id, :area_id, :days_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def not_exhibitor
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end
end