# OmniAuth Auth.sch Strategy

Strategy to authenticate with Auth.sch in OmniAuth.

Get your API key at: http://auth.sch.bme.hu

## Installation

Add to your `Gemfile`:

```ruby
gem 'omniauth-authsch'
```

Then `bundle install`.

## Usage with Devise

First define your application id and secret in `config/initializers/devise.rb`.

Configuration options can be passed as the last parameter here as key/value pairs.

```ruby
config.omniauth :authsch, ENV['AUTHSCH_CLIENT'], ENV['AUTHSCH_KEY'], scope: ENV['AUTHSCH_SCOPES']
```

Then add the following to `config/routes.rb` so the callback routes are defined.

```ruby
devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
```

Make sure your model is omniauthable. Generally this is `app/models/user.rb`

```ruby
devise :omniauthable, omniauth_providers: [:authsch]
```

Then make sure your callbacks controller is setup in `app/controllers/users/omniauth_callbacks_controller.rb`

```ruby
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def authsch
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Auth.sch'
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to root_path, alert: @user.errors.full_messages.join('\n')
    end
  end
end
```

and bind to or create the user in `app/models/user.rb`

```ruby
def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data['email'])

    # Uncomment the section below if you want users to be created if they don't exist
    # unless user
    #     user = User.create(name: data['name'],
    #        email: data['email'],
    #        password: Devise.friendly_token[0,20]
    #     )
    # end
    user
end
```

For your views you can login using:

```erb
<%= link_to "Sign in with Auth.sch", user_authsch_omniauth_authorize_path %>
```

An overview is available at https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview

## License

Copyright (c) 2017 by Zsolt Kozaroczy

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
