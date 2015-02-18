require 'sage_pay'

module Spree
  class Gateway::SagepayServer < Gateway
    preference :vendor, :string
    preference :mode, :string, default: 'test'
    preference :proxy_enabled, :boolean, default: false
    preference :proxy_host, :string
    preference :proxy_port, :integer
    preference :profile, :string, default: 'low'

    def supports?(source)
      true
    end

    def provider_class
      ::SagePay::Server
    end

    def auto_capture?
      true
    end

    def method_type
      'sagepay'
    end

    def purchase(amount, sagepay_checkout, gateway_options = {})
      Class.new do
        def success?; true; end
        def authorization; nil; end
      end.new
    end
  end
end
