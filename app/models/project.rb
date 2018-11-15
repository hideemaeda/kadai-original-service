class Project < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :comment, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  
  belongs_to :user
  
  has_many :pjmembers
  has_many :assign_users, through: :pjmembers, source: :user
  
  has_many :tasks
  
  def pjmember(user)
    self.pjmembers.find_or_create_by(user_id: user.id)
  end
  
  def unpjmember(user)
    like = self.pjmembers.find_by(user_id: user.id)
    like.destroy if pjmember
  end
  
  def pjmember?(user)
    self.pjmember_users.include?(user)
  end
end
