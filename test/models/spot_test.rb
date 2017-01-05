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

require 'test_helper'

class SpotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
