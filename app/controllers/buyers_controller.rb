class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :restriction
  
  def index
    @buyer_order = BuyerOrder.new
  end

  def create
    @buyer_order = BuyerOrder.new(buyer_params)
    if @buyer_order.valid?
      pay_item
      @buyer_order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def buyer_params
    params.permit(:item_id, :postal_code, :area_id, :city, :address, :building, :phone_num).merge(user_id: current_user.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def restriction
    if current_user.id == @item.user_id || @item.buyer != nil
      redirect_to root_path
    end
  end
end