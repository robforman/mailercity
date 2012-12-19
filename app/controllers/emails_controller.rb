class EmailsController < ApplicationController
  def create
    mailer_class = class_get(params.fetch(:mailer).camelcase)
    template_method = params.fetch(:template).to_sym

    if mailer_class && mailer_class.respond_to?(template_method)
      args = params.fetch(:args)
      email = mailer_class.public_send(template_method, *args).deliver
      head :created, :location => "/"
    else
      head :bad_request
    end
  end

  private

  def class_get(class_name)
    klass = Kernel.const_get(class_name)
    return klass.is_a?(Class) ? klass : nil
  rescue NameError
    return nil
  end
end
