class Sound < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  validates :creator, :title, :file, presence: true
  mount_uploader :file, SoundUploader
end
