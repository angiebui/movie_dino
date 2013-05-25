ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "moviedino.com",
  user_name: ENV["GMAIL_NAME"],
  password: ENV["GMAIL_PASSWORD"],
  authentication: "plain",
  enable_starttls_auto: true
}
