class Cocktail < ApplicationRecord
  include PgSearch::Model
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo


  belongs_to :user
  # has_many :users, through: :saved_cocktails

  validates :name, presence: true, uniqueness: true

  pg_search_scope :flavor_search, associated_against: {
    ingredients: :name
  }
end
