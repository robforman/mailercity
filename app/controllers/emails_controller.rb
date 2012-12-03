class EmailsController < ApplicationController
  def create
    mailer = params.fetch(:mailer).camelcase.constantize
    template = params.fetch(:template).to_sym
    Rails.logger.info("Sending #{mailer}.#{template}")

    # TODO: check if this mailer and template exist

    email = mailer.public_send(template, params).deliver
    render nothing: true, success: true
  end
end
