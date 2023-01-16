class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  
  def create_notification_follow!(current_customer)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  
  def self.guest
    find_or_create_by!(name: 'ゲスト' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
    end
  end
  
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end
  def following?(customer)
    followings.include?(customer)
  end

  validates :name, length: { maximum: 20 }, uniqueness: true
  validates :introduction, length: {maximum: 50}

  def self.looks(search, word)
   if search == "perfect_match" #完全一致
     @customer = Customer.where("name LIKE?","#{word}")
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
