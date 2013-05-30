class EmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: 3

  def perform(user_id, outing_id, email_type)
    if email_type == "invite"
      UserMailer.outing_invite(user_id, outing_id).deliver
    elsif email_type == "result"
      UserMailer.outing_result(user_id, outing_id).deliver
    end
  end
end
