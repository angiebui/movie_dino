class UserMailer < ActionMailer::Base
  default from: "Movie Dino <dino@moviedino.com>"

  def outing_invite(user_id, outing_id)
    @user = User.find(user_id)
    @outing = Outing.find(outing_id)
    email_with_name = "#{@user.first_name} <#{@user.email}>"

    mail(to: email_with_name, subject: "Share your Movie Dino event with friends!")
  end

  def outing_result(user_id, outing_id)
    @user = User.find(user_id)
    @outing = Outing.find(outing_id)
    email_with_name = "#{@user.first_name} <#{@user.email}>"
    
    mail(to: email_with_name, subject: "Results are in. Time to watch a movie!")
  end
end

