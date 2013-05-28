class UserMailer < ActionMailer::Base
  default from: "dino@moviedino.com"

  def outing_invite(user_id, outing_id)
    @user = User.find(user_id)
    @outing = Outing.find(outing_id)
    mail(to: @user.email, subject: "Share your Movie Dino event with friends!")
  end

  def outing_result(user_id, outing_id)
    @user = User.find(user_id)
    @outing = Outing.find(outing_id)
    mail(to: @user.email, subject: "Results are in. Time to watch a movie!")
  end
end

