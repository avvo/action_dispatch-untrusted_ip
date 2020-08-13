# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'action_dispatch/untrusted_ip/version'

Gem::Specification.new do |spec|
  spec.name          = "action_dispatch-untrusted_ip"
  spec.version       = ActionDispatch::UntrustedIp::VERSION
  spec.authors       = ["Jeff Ching"]
  spec.email         = ["ching.jeff@gmail.com"]

  spec.summary       = %q{Defines request.untrusted_ip}
  spec.description   = %q{Defines request.untrusted_ip from the HTTP_X_ORIG_FORWARDED_FOR header}
  spec.homepage      = "http://github.com/avvo/action_dispatch-untrusted_ip"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://avvo-gems.public.artifactory.internetbrands.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack", "~> 4.2"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
