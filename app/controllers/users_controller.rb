class UsersController < ApplicationController
  def show
    @my_cocktails = Cocktail.where(user: current_user)
    # @saved_cocktails = SavedCocktail.where(user: current_user).includes(:cocktail)
  end
end
