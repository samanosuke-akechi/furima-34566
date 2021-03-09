class BuyersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @buyer_order = BuyerOrder.new
  end

  def create
    @buyer_order = BuyerOrder.new(buyer_params)
    if @buyer_order.valid?
      @buyer_order.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def buyer_params
    params.permit(:item_id, :postal_code, :area_id, :city, :address, :building, :phone_num).merge(user_id: current_user.id)
  end
end