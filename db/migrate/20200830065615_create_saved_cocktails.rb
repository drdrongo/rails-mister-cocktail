class CreateSavedCocktails < ActiveRecord::Migration[6.0]
  def change
    create_table :saved_cocktails do |t|
      t.references :user
      t.references :cocktail

      t.timestamps
    end
  end
end
