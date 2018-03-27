class LineItemsController < ApplicationController
  def create
    line_item = nil
    item = Item.find(params[:item_id])
    if current_user.current_cart.nil?
      line_item = current_user.build_current_cart.add_item(item.id)
    else
      line_item = current_user.current_cart.add_item(item.id)
    end
    line_item.save
    redirect_to cart_path(current_user.current_cart)
  end
end
