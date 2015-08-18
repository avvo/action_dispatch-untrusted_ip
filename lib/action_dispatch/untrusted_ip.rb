require "action_dispatch/untrusted_ip/version"

module ActionDispatch
  module UntrustedIp
    def untrusted_ip
      untrusted_ips = split_ip_addresses(@env['HTTP_X_ORIG_FORWARDED_FOR'])
      untrusted_ips = reject_trusted_ip_addresses(untrusted_ips)

      return untrusted_ips.first if untrusted_ips.any?

      # fallback to the default ip
      ip
    end
  end
end

ActionDispatch::Request.send(:include, ActionDispatch::UntrustedIp)