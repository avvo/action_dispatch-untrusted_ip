# ActionDispatch::UntrustedIp

This gem tries to centralize handling of untrusted HTTP_X_FORWARDED_FOR headers. If a user is using an external proxy that sets an HTTP_X_FORWARDED_FOR header, we will normally reject it at our load balancer. Instead, we pass this value to our applications as HTTP_X_ORIG_FORWARDED_FOR and let our applications decide what to do with it. This gem provides a simple accessor on the `ActionDispatch::Request` object.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'action_dispatch-untrusted_ip'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install action_dispatch-untrusted_ip

## Usage

This gem adds additional functionality to the ActionDispatch::Request object.

```ruby
request.untrusted_ip
```

## Contributing

Bug reports and pull requests are welcome on GitLab at https://github.com/avvo/action_dispatch-untrusted_ip.
