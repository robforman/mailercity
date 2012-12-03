require_relative "../../lib/mailer_city"

describe MailerCity do
  it "can deliver with hard-coded structures" do
    mail = MailerCity::TestMailer.test_template(user_email: "rob@robforman.com")
    mail.deliver.should == 'https://mailerhost/test_mailer/test_template?{:user_email=>"rob@robforman.com"}'
  end

  it "can create dynamic mailers" do
    mail = MailerCity::MyNewMailer.test_template(user_email: "rob@robforman.com")
    mail.deliver.should == 'https://mailerhost/my_new_mailer/test_template?{:user_email=>"rob@robforman.com"}'
  end

  it "can create dynamic templates" do
    mail = MailerCity::TestMailer.my_new_template(user_email: "rob@robforman.com")
    mail.deliver.should == 'https://mailerhost/test_mailer/my_new_template?{:user_email=>"rob@robforman.com"}'
  end
end