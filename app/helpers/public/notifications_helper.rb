module Public::NotificationsHelper
  
  def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end
  
  def notification_form(notification)
    @comment = nil
    visiter = notification.visiter.name
    your_post = "あなたの投稿"
    # visiter = link_to notification.visiter.name, notification.visiter, style:"font-weight: bold;"
    # your_post = link_to "あなたの投稿", notification.post, style:"font-weight: bold;", remote: true
    case notification.action
      when "follow" then
        "#{visiter}があなたをフォローしました"
      when "comment" then
        @comment=Comment.find_by(id:notification.comment_id)
        "#{visiter}が#{your_post}にコメントしました"
    end
  end
end
