module Public::NotificationsHelper
  
  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end
  
  def notification_form(notification)
    @comment = nil
    visiter = notification.visiter.name
    your_post = "あなたの投稿"
    case notification.action
      when "follow" then
        "#{visiter}があなたをフォローしました"
      when "comment" then
        @comment=Comment.find_by(id:notification.comment_id)
        "#{visiter}が#{your_post}にコメントしました"
    end
  end
end
