class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :name, length: { minimum: 1, maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}
  
  def self.looks(search, word)
   if search == "perfect_match" #完全一致
     @customer = Customer.where("name LIKE?", "#{word}")
   elsif search == "forward_match" #前方一致
     @customer = Customer.where("name LIKE?","#{word}%")
   elsif search == "backward_match" #後方一致
     @customer = Customer.where("name LIKE?","%#{word}")
   elsif search == "partial_match" #部分一致
     @customer = Customer.where("name LIKE?","%#{word}%")
   else
     @customer = Customer.all
   end
  end
  
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'busyou.png'
  end
  
end
