# Mailercity

Mailercity is a central email repository and sending service.  This decouples any design and copy changes from the services that use them.  It also provides a central place for tracking email delivery, bounces, etc. through a relay gateway like Sendgrid.

## Usage

There are two components.  First, setup your email templates in the Mailercity Rails app as normal.  Second, use the mailercity gem (https://github.com/robforman/mailercity-ruby) to remotely pass data and send your email.

### Setting Up Your Email Templates

This is standard Rails stuff (more information here: http://guides.rubyonrails.org/action_mailer_basics.html).

1. Create your action mailer as normal.

```
$ rails generate mailer UserMailer
create  app/mailers/user_mailer.rb
invoke  erb
create    app/views/user_mailer
invoke  test_unit
create    test/functional/user_mailer_test.rb
```

2. Add your new mailer action, such as welcome_email.

```ruby
class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"

  def welcome_email(email)
    @url  = "http://example.com/login"
    mail(:to => email, :subject => "Welcome to My Awesome Site")
  end
end
```

3. Setup your mailer views.

Put your text and html content into:
* app/views/user_mailer/welcome_email.text.erb
* app/views/user_mailer/welcome_email.html.erb

4. Test sending your new email from within Mailercity console

```ruby
UserMailer.welcome_email("rob@robforman.com").deliver
```

### Send Email Remotely

1. Add mailercity to your remote project's `Gemfile` and run `bundle install`.

2. Setup your api key in `config/initializers/mailercity.rb`

```ruby
Mailercity.api_key = "xxxxxxxxxxxxxxxxxxxxxxx"
```

3. Call your mailer remotely

```ruby
Mailercity::UserMailer.welcome_email("rob@robforman.com").deliver
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
