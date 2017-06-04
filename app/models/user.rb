class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, length: { maximum: 50 },
                       uniqueness: { case_sensitive: false },
                       format: { without: /\s/ }
  
  has_many :lists, dependent: :destroy
 
  # Returns the user's active list
  # The active list is the newest list chronologically which is
  # determined by the created_at (desc) index on List
  def active_list
    lists.first 
  end
  
  # Wrapper around the Devise encryption digest
  # Params
  # +string+:: string to be converted into a digest
  def User.digest(string)
    Devise::Encryptor.digest(User, string) 
  end 
end
