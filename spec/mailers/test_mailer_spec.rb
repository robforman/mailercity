require "spec_helper"

describe TestMailer do
  describe "test_template" do
    it "should have test text" do
      email = TestMailer.test_template(user_email: "rob@robforman.com").deliver
      ActionMailer::Base.deliveries.empty?.should be_false
      email.to.should == ["rob@robforman.com"]
      email.subject.should == "Test Template"
      email.encoded.should match(%r(This is the test text template to rob@robforman.com.))
      email.encoded.should match(%r(<p>This is the test html template to rob@robforman.com.</p>))
    end
  end
end
