class Slide < ApplicationRecord
  mount_uploader :image, ImageUploader
  scope :active, lambda { where("start_at is null or start_at <= ?", Date.today).where("end_at is null or end_at > ?", Date.today) }
end
