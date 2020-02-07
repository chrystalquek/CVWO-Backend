class Todo < ApplicationRecord
  # user has many todos relationship
  belongs_to :user

  # ensures that title and tag are present, otherwise frontend will display corresponding error
  validates :title, presence: true
  validates :tag, presence: true

end
