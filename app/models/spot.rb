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
  geocoded_by :address
  after_validation :geocode
  validates :user_id, presence: true
  validates :description, presence: true
  
end
