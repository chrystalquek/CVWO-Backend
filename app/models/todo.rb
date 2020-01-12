class Todo < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :tag, presence: true
  
  # validates_format_of :duedate, :with =>  ^\d{4}\/\d{2}\/\d{2} \d{2}:\d{2}:\d{2}

  # ^(\d{1,2}\/){2}\d{4}\s+((\d+)(\:)){2}\d+\s+(AM|PM)
  
   
end
