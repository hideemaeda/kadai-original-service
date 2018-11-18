class Task < ApplicationRecord
  belongs_to :project
  
  has_many :assign_members, dependent: :destroy
  has_many :task_menbers, through: :assign_members, source: :user, dependent: :destroy
  
  validates :title, presence: true, length: {maximum: 10}
  validates :priority, presence: true
  validates :schedule, presence: true
  validates :progress, presence: true
  validates :alarm, presence: true
  validates :comment, presence: true
  
  def assign_member(user)
    self.assign_members.find_or_create_by(user_id: user.id)
  end
  
  def assignout(user)
    assign_member = self.assign_members.find_by(user_id: user.id)
    assign_member.destroy if assign_member
  end
  
  def assign_member?(user)
    self.assign_member_tasks.include?(user)
  end
  
end