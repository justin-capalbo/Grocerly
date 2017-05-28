class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, length: { maximum: 50 },
                       uniqueness: { case_sensitive: false }

  def User.digest(string)
    Devise::Encryptor.digest(User, string) 
  end 
end
