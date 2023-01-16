class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :comments,dependent: :destroy
  validates :castle,presence:true
  validates :body,presence:true,length:{maximum:200}
  has_many :bookmarks, dependent: :destroy
  has_many :notifications, dependent: :destroy

  scope :published, -> {where(is_published_flag: true)}
  scope :unpublished, -> {where(is_published_flag: false)}

  def create_notification_comment!(current_customer, comment_id)
    temp_ids = Comment.select(:customer_id).where(post_id: id).where.not(customer_id: current_customer.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_customer, comment_id, temp_id['customer_id'])
    end
    save_notification_comment!(current_customer, comment_id, customer_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_customer, comment_id, visited_id)
    notification = current_customer.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

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
