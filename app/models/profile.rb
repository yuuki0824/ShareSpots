class Profile < ActiveRecord::Base
  belongs_to :user
  
  validates :age, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }
  validates :birthplace,length: {maximum: 50}
  validates :self_introducation, length: {maximum: 400}
end
