class UserMailer < ActionMailer::Base
  default from: "dino@moviedino.com"

  def outing_invite(user_id, outing_id)
    @user = User.find(user_id)
    @outing = Outing.find(outing_id)
    mail(to: @user.email, subject: "Forward me to your friends.")
  end

  def outing_result(user_id, outing_id)
    @user = User.find(user_id)
    @outing = Outing.find(outing_id)
    mail(to: @user.email, subject: "It's time to go out!")
  end
end

