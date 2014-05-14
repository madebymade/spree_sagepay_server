Spree::CheckoutController.class_eval do
  skip_before_filter :setup_for_current_state
  before_filter :setup_with_sagepay

  def setup_with_sagepay
    setup_for_current_state
    setup_sagepay if @order.state == 'payment'
  end

  def setup_sagepay
    return unless has_sagepay_gateway?
    @sage_pay = register_with_sage_pay

    if @sage_pay.status == :ok
      create_pending_payment
    end
  end

  private

  def has_sagepay_gateway?
    payment_method.present?
  end

  def create_pending_payment
    @order.payments.create({
      :amount         => @order.total,
      :source         => Spree::SagepayServerCheckout.create({
        :security_key => @sage_pay.security_key,
        :vpstx_id => @sage_pay.vps_tx_id
      }, :without_protection => true),
      :state          => :pending,
      :payment_method => payment_method,
    }, :without_protection => true)
  end

  def payment_method
    Spree::PaymentMethod.find(:first,
      :conditions => {
        :environment => Rails.env,
        :active => true,
        :type => "Spree::Gateway::SagepayServer"
      }
    )
  end

  def register_with_sage_pay
    registered_payment = SagePay::Server.payment({
      :http_proxy => use_proxy,
      :amount => @order.total,
      :currency => @order.currency,
      :customer_email => @order.email,
      :description => @order.number,
      :notification_url => notification_url,
      :billing_address => @order.bill_address.sage_pay_address,
      :delivery_address => @order.ship_address.sage_pay_address,
      :profile => :low
    })

    registered_payment.run!
  end

  def notification_url
    spree.sagepay_notification_url(:payment_method_id => payment_method.id)
  end

  def use_proxy
    return false unless payment_method.preferred_proxy_enabled

    "#{payment_method.preferred_proxy_host}:#{payment_method.preferred_proxy_port}"
  end
end
