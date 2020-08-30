class AddCreatorToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_reference :cocktails, :user, index: true
    add_foreign_key :cocktails, :users
  end
end
