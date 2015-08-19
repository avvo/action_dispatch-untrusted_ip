require 'test_helper'

class ActionDispatch::UntrustedIpTest < Minitest::Test
  def setup
    @env = {
      :ip_spoofing_check => true,
      :tld_length => 1,
      "rack.input" => "foo"
    }
  end

  def test_that_it_has_a_version_number
    refute_nil ::ActionDispatch::UntrustedIp::VERSION
  end

  def test_that_we_read_the_original_x_forwarded_for_header
    request = stub_request({
      'HTTP_X_ORIG_FORWARDED_FOR' => '1.2.3.4'
    })
    assert_equal '1.2.3.4', request.untrusted_ip
  end

  def test_that_we_strip_trusted_proxies
    request = stub_request({
      'HTTP_X_ORIG_FORWARDED_FOR' => '10.1.1.14,1.2.3.4'
    })
    assert_equal '1.2.3.4', request.untrusted_ip
  end

  def test_that_we_dont_crash_when_header_is_absent
    request = stub_request
    assert request.untrusted_ip.blank?
  end

  def test_that_we_fallback_to_request_ip
    request = stub_request({
      'REMOTE_ADDR' => '2.3.4.5'
    })
    assert_equal '2.3.4.5', request.ip
    assert_equal '2.3.4.5', request.untrusted_ip
  end

  protected

  # taken from ActionDispatch tests
  def stub_request(env = {})
    ip_spoofing_check = env.key?(:ip_spoofing_check) ? env.delete(:ip_spoofing_check) : true
    @trusted_proxies ||= nil
    ip_app = ActionDispatch::RemoteIp.new(Proc.new { }, ip_spoofing_check, @trusted_proxies)
    tld_length = env.key?(:tld_length) ? env.delete(:tld_length) : 1
    ip_app.call(env)
    ActionDispatch::Http::URL.tld_length = tld_length

    env = @env.merge(env)
    ActionDispatch::Request.new(env)
  end
end
