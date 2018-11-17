class Project < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :comment, presence: true
  validates :start_day, presence: true
  validates :end_day, presence: true
  
  belongs_to :user
  
  has_many :pjmembers, dependent: :destroy
  has_many :assign_users, through: :pjmembers, source: :user
  
  has_many :tasks, dependent: :destroy
  
  def pjmember(user)
    self.pjmembers.find_or_create_by(user_id: user.id)
  end
  
  def pjout(user)
    pjmember = self.pjmembers.find_by(user_id: user.id)
    pjmember.destroy if pjmember
  end
  
  def pjmember?(user)
    self.pjmember_users.include?(user)
  end
end
