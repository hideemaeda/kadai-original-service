class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :projects, dependent: :destroy
  
  has_many :pjmembers, dependent: :destroy
  has_many :assign_projects, through: :pjmembers, source: :project, dependent: :destroy
  
  has_many :tasks, dependent: :destroy
  
  has_many :assign_members, dependent: :destroy
  has_many :task_menbers, through: :assign_members, source: :task, dependent: :destroy
  
  def pjmember(project)
    self.pjmembers.find_or_create_by(project_id: project.id)
  end
  
  def pjout(project)
    pjmember = self.pjmembers.find_by(project_id: project.id)
    pjmember.destroy if pjmember
  end
  
  def pjmember?(project)
    self.pjmember_ids.include?(project)
  end
  
  def assign_member(task)
    self.assign_members.find_or_create_by(task_id: task.id)
  end
  
  def assignout(task)
    assign_member = self.assign_members.find_by(task_id: task.id)
    assign_member.destroy if assign_member
  end
  
  def assign_member?(task)
    self.assign_member_tasks.include?(task)
  end
end
