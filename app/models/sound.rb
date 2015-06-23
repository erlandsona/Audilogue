class Sound < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  validates :creator, :title, :url, presence: true
end
