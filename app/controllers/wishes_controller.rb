class WishesController < ApplicationController
  def show
    @wish = Wish.find(params[:id])
    render :layout => false
  end
end
