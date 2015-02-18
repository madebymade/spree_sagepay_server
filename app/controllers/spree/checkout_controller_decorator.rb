Spree::CheckoutController.class_eval do
  alias_method :original_before_payment, :before_payment

  def before_payment
    original_before_payment
    setup_sagepay
  end

  def setup_sagepay
    return unless has_sagepay_gateway?
    @payment = register_with_sagepay

    if @payment.status == :ok
      create_checkout_payment
    else
      flash[:error] = 'Unable to register payment'
    end
  end

  private

  def has_sagepay_gateway?
    payment_method.present?
  end

  def create_checkout_payment
    @order.payments.create!(
      source: source,
      payment_method: payment_method
    )
  end

  def source
    Spree::SagepayServerCheckout.create!(
      security_key: @payment.security_key,
      vpstx_id: @payment.vps_tx_id
    )
  end

  def payment_method
    Spree::PaymentMethod.find_by(
      environment: Rails.env,
      active: true,
      type: 'Spree::Gateway::SagepayServer'
    )
  end

  def register_with_sagepay
    registered_payment = SagePay::Server.payment(
      http_proxy: use_proxy,
      mode: payment_method.preferred_mode.to_sym,
      profile: payment_method.preferred_profile.to_sym,
      vendor: payment_method.preferred_vendor,
      amount: @order.total,
      currency: @order.currency,
      customer_email: @order.email,
      description: @order.number,
      notification_url: notification_url,
      billing_address: @order.bill_address.sagepay_address,
      delivery_address: @order.ship_address.sagepay_address
    )

    registered_payment.run!
  end

  def notification_url
    spree.sagepay_notification_url(payment_method_id: payment_method.id)
  end

  def use_proxy
    return false unless payment_method.preferred_proxy_enabled

    "#{payment_method.preferred_proxy_host}:#{payment_method.preferred_proxy_port}"
  end
end
