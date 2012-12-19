require "spec_helper"

describe TestMailer do
  describe "test_template" do
    it "should have test text" do
      user = JSON.parse('{"id":1,"email":"rob@robforman.com","first_name":"Rob","last_name":"Forman"}')
      account = JSON.parse('{"id":1,"name":"Awesometown"}')

      email = TestMailer.test_template(user, account).deliver
      ActionMailer::Base.deliveries.empty?.should be_false
      email.to.should == ["rob@robforman.com"]
      email.subject.should == "Test Template for Awesometown"
      email.encoded.should match(%r(This is the test text template to rob@robforman.com.))
      email.encoded.should match(%r(<p>This is the test html template to rob@robforman.com.</p>))
    end
  end
end
