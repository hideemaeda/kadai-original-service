class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :projects
  has_many :pjmembers
  has_many :assign_projects, through: :pjmembers, source: :project
  
  def pjmember(project)
    self.pjmembers.find_or_create_by(project_id: project.id)
  end
  
  def unpjmember(project)
    like = self.pjmembers.find_by(project_id: project.id)
    like.destroy if pjmember
  end
  
  def pjmember?(project)
    self.pjmember_projects.include?(project)
  end
end
