class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :comments,dependent: :destroy
  validates :castle,presence:true
  validates :body,presence:true,length:{maximum:200}
  
  has_many :bookmarks, dependent: :destroy
  def bookmarked_by?(customer)
    bookmarks.where(customer_id: customer).exists?
  end
  
  def self.looks(search, word)
    if search == "perfect_match" #完全一致
      @post = Post.where("castle LIKE?","#{word}")
    elsif search == "forward_match" #前方一致
      @post = Post.where("castle LIKE?","#{word}%")
    elsif search == "backward_match" #後方一致
      @post = Post.where("castle LIKE?","%#{word}")
    elsif search == "partial_match" #部分一致
      @post = Post.where("castle LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
  def get_image
    unless image.attached?
     file_path = Rails.root.join('app/assets/images/castle.jpeg')
     image.attach(io: File.open(file_path), filename: 'busyou.png', content_type: 'image/png')
    end
    image
  end
end
