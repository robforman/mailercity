require 'spec_helper'

describe EmailsController do

  describe "POST 'create'" do
    it "routes to the email controller's create action" do
       { :post => '/deliver/test_mailer/test_template' }.should route_to(:controller => 'emails', :action => 'create', :mailer => 'test_mailer', :template => 'test_template')
    end

    context "a known mailer and template" do
      it "should succeed" do
         post :create, :mailer => 'test_mailer', :template => 'test_template', :user_email => "rob@robforman.com"
         response.should be_success
      end

      it "sends an email" do
        post :create, :mailer => 'test_mailer', :template => 'test_template', :user_email => "rob@robforman.com"
        ActionMailer::Base.deliveries.empty?.should be_false
      end

      it "creates an email object"
    end

    context "an nonexistent mailer" do
      it "should fail" do
         post :create, :mailer => 'nonexistent_mailer', :template => 'test_template', :user_email => "rob@robforman.com"
         response.should_not be_success
      end
    end

    context "an nonexistent template" do
      it "should fail" do
         post :create, :mailer => 'test_mailer', :template => 'nonexistent_template', :user_email => "rob@robforman.com"
         response.should_not be_success
      end
    end
  end
end
