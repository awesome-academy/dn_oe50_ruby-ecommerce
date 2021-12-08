class CartsController < ApplicationController
  before_action :find_product,
                :get_line_item,
                :check_residual_quantity?,
                only: [:create, :destroy, :update]
  before_action :logged_in?, only: [:index, :create]

  def index
    @cart_items = get_line_items_in_cart
    @cart_items.reverse!
  end

  def create
    if @item
      @item["quantity"] += params[:quantity].to_i
      flash[:info] = t "cart.cart_add"
    else
      current_cart << {product_id: @product.id, quantity: params[:quantity].to_i}
      flash[:success] = t "cart.cart_success"
    end
    session[:cart] = current_cart
    redirect_to root_path
  end

  def destroy
    if @item
      flash[:success] = t "cart.remove_cart_success"
      current_cart.delete(@item)
    else
      flash[:danger] = t "cart.remove_cart_fail"
    end
    redirect_to carts_path
  end

  def update
    if @item
      @item["quantity"] = params[:quantity].to_i
      flash.now[:success] = t "cart.update_cart_success"
    else
      flash[:danger] = t "cart.update_cart_fail"
    end
    redirect_to carts_path
  end

  private

  def check_residual_quantity?
    quantity = if @item
                 @item["quantity"] + params[:quantity].to_i
               else
                 params[:quantity].to_i
               end
    return if @product.check_residual_quantity? quantity

    flash[:danger] = t "cart.not_enough_product"
    redirect_to root_path
  end

  def get_line_item
    @item = find_product_in_cart @product
  end
end