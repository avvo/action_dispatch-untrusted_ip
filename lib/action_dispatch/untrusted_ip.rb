require "action_dispatch"
require "action_dispatch/untrusted_ip/version"

module ActionDispatch
  module UntrustedIp
    def untrusted_ip
      untrusted_ips.tap do |ips|
        return ips.first if ips.any?
      end

      # fallback to the default ip
      ip
    end

    def untrusted_ips
      reject_trusted_ip_addresses(split_ip_addresses(@env['HTTP_X_ORIG_FORWARDED_FOR']))
    end
  end
end

ActionDispatch::Request.send(:include, ActionDispatch::UntrustedIp)