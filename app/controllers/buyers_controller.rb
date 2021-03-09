class BuyersController < ApplicationController
  def index
    @buyer_order = BuyerOrder.new
    item_info
  end

  def create
    @buyer_order = BuyerOrder.new(buyer_params)
    if @buyer_order.valid?
      pay_item
      @buyer_order.save
      redirect_to root_path
    else
      item_info
      render :index
    end
  end

  private

  def buyer_params
    params.permit(:item_id, :postal_code, :area_id, :city, :address, :building, :phone_num).merge(user_id: current_user.id, token: params[:token])
  end

  def item_info
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = "sk_test_***********"
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end