class EmailWorker
  include Sidekiq::Worker

  def perform(user_id, outing_id, email_type)
    if email_type == "invite"
      UserMailer.outing_invite(user_id, outing_id).deliver
    elsif email_type == "result"
      UserMailer.outing_result(user_id, outing_id).deliver
    end
  end

  def perform_at(datetime, user_id, outing_id)
    UserMailer.outing_result(user_id, outing_id).deliver
  end
  
end
