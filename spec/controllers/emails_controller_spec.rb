require 'spec_helper'

describe EmailsController do

  let(:user) { {"id"=>1, "email"=>"rob@robforman.com", "first_name"=>"Rob", "last_name"=>"Forman"} }
  let(:account) { {"id"=>1, "name"=>"Awesometown"} }

  describe "POST 'create'" do
    it "routes to the email controller's create action" do
       { :post => '/test_mailer/test_template' }.should route_to(:controller => 'emails', :action => 'create', :mailer => 'test_mailer', :template => 'test_template')
    end

    context "a known mailer and template" do
      it "succeeds" do
         post :create, :mailer => 'test_mailer', :template => 'test_template', :args => [user, account], :format => :json
         response.should be_success
      end

      it "sends an email" do
        post :create, :mailer => 'test_mailer', :template => 'test_template', :args => [user, account], :format => :json
        ActionMailer::Base.deliveries.empty?.should be_false
      end

      it "creates an email object"
    end

    context "an nonexistent mailer" do
      it "should fail" do
         post :create, :mailer => 'nonexistent_mailer', :template => 'test_template', :args => [user, account], :format => :json
         response.should_not be_success
      end
    end
    
    context "an nonexistent template" do
      it "should fail" do
         post :create, :mailer => 'test_mailer', :template => 'nonexistent_template', :args => [user, account], :format => :json
         response.should_not be_success
      end
    end
  end
end
