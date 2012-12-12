class TestMailer < ActionMailer::Base
  default from: "from@example.com"

  def test_template(args)
    @user_email = args.fetch(:user_email)
    mail(:to => @user_email, :subject => "Test Template")
  end
end
