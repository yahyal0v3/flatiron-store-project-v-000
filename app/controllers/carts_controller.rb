class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :checkout]

   def show
   end

   def checkout
      @current_cart.line_items.each do |line_item|
        line_item.item.inventory -= line_item.quantity
        line_item.item.save
      end
      @current_cart.update(status: "Submitted")
      current_user.update(current_cart: nil)
      redirect_to cart_path(@current_cart)
    end

  private
    def set_cart
      @current_cart = Cart.find(params[:id])
    end

end
