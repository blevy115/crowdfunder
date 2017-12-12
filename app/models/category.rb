class Category < ApplicationRecord
  has_and_belongs_to_many :projects

  validates :tag, presence: true

end
