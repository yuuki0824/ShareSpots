# == Schema Information
#
# Table name: spots
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  date        :string
#  address     :string
#  description :string
#  latitude    :float
#  longitude   :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Spot < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :like_users, through: :likes, source: :user
  geocoded_by :address
  after_validation :geocode
  validates :user_id, presence: true
  validates :description, presence: true
  
  mount_uploader :image, ImageUploader
  
  
  def like?(user)
    like_users.include?(user)
  end
end
