class BuyersController < ApplicationController
  before_action :authenticate_user!
  before_action :not_buyer
  before_action :sold_item
  
  def index
    @buyer_order = BuyerOrder.new
    set_item
  end

  def create
    @buyer_order = BuyerOrder.new(buyer_params)
    if @buyer_order.valid?
      pay_item
      @buyer_order.save
      redirect_to root_path
    else
      set_item
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
    Payjp.api_key = ""
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

  def not_buyer
    set_item
    if current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def sold_item
    @buyer = Buyer.all
    set_item
    @buyer.each do |buyer|
      if buyer.item_id == @item.id
        redirect_to root_path
      end
    end
  end
end