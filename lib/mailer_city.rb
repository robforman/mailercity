require 'active_support/inflector'

module MailerCity
  def self.const_missing(const_name)
    new_class = Class.new(super_class=Mail)

    # Non-obvious: we assign it to a const in order to name.
    const_set(const_name, new_class)
  end

  class Mail
    attr_reader :template, :params

    def  initialize(args)
      @template = args.fetch(:template)
      @params = args.fetch(:params)
    end

    def deliver
      "https://mailerhost/#{mailer_name}/#{template}?#{params.inspect}"
    end

    def mailer_name
      self.class.name.split(/::/).last.underscore
    end

    def self.method_missing(method_name, args, &block)
      new(template: method_name, params: args)
    end

    def self.test_template(args)
      new(template: "test_template", params: args)
    end
  end
end

class TestMailer < MailerCity::Mail
end
