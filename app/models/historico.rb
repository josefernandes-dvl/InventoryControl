class Historico < ApplicationRecord
  belongs_to :product
  validates :action_type, :user, presence: true
end
