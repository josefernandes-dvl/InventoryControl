class Product < ApplicationRecord

    include Pagy::Backend

    belongs_to :category
    has_many :historicos
    
    accepts_nested_attributes_for :category, reject_if: :all_blank
    scope :search_by_title, ->(term) { where("title ILIKE ?", "%#{term}%") }

    validates :title, presence: true
    validates :description, length: { minimum: 10 }
    validates :price, numericality: { greater_than: 0 }
    validates :buy, inclusion: { in: [true, false] }
end