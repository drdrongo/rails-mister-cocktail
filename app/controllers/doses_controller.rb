class DosesController < ApplicationController
  before_action :find_cocktail, only: %i[index create]

  def index
    @dose = Dose.new
    @doses = Dose.where(cocktail_id: params[:cocktail_id])
    render template: 'cocktails/show'
  end

  def create
    @dose = Dose.new(dose_params)
    @dose.cocktail = @cocktail
    if @dose.save
      redirect_to cocktail_path(@dose.cocktail)
    else
      @doses = Dose.where(cocktail_id: params[:cocktail_id])
      render template: 'cocktails/show'
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @cocktail = @dose.cocktail_id
    @dose.destroy

    redirect_to cocktail_path(@cocktail)
  end

  private

  def find_cocktail
    @cocktail = Cocktail.find(params[:cocktail_id])
  end

  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end
