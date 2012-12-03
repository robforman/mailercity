class TestMailer < ActionMailer::Base
  default from: "from@example.com"

  def test_template(args)
    mail(:to => args.fetch(:user_email), :subject => "Test Template")
  end
end
