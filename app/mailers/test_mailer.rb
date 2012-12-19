
class TestMailer < ActionMailer::Base
  default from: "from@example.com"

  def test_template(user, account)
    @user = OpenStruct.new(user)
    @account = OpenStruct.new(account)
    mail(:to => @user.email, :subject => "Test Template for #{@account.name}")
  end
end
