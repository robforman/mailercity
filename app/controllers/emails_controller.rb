class EmailsController < ApplicationController
  def create
    email = TestMailer.test_template(params).deliver
    render nothing: true, success: true
  end
end
