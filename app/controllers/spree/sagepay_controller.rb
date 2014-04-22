module Spree
  class SagepayController  < StoreController
    skip_before_filter :verify_authenticity_token, :only => :notification
    before_filter :sagepay_notification, :only => :notification

    def notification
      unless authorized?
        render(
          :layout => false,
          :text => sagepay_notification.response(redirect_url(sagepay_notification.status, spree_order))
        ) and return
      end

      if sagepay_notification.valid_signature? and sagepay_notification.status == :ok
        complete_payment
      else
        fail_payment
      end

      spree_order.next

      render(
        :layout => false,
        :text => sagepay_notification.response(redirect_url(sagepay_notification.status, spree_order))
      )
    end

    private

    def spree_order
      @order ||= payment_source.payments.first.order
    end

    def sagepay_notification
      @sagepay_notification ||= SagePay::Server::Notification.from_params(params, verification_details)
    end

    def payment_method
      @payment_method ||= Spree::PaymentMethod.find(params[:payment_method_id])
    end

    def payment_source
      @payment_source ||= Spree::SagepayServerCheckout.find_by_vpstx_id(params['VPSTxId'])
    end

    def authorized?
      params['Status'] == "OK"
    end

    def provider
      payment_method.provider
    end

    def complete_payment
      payment_source.payments.first.update_attributes({
        :state => :complete
      }, :without_protection => true)
    end

    def fail_payment
      payment_source.payments.first.update_attributes({
        :state => :failed
      }, :without_protection => true)
    end

    def failed_url
      spree.checkout_state_url(spree_order.state)
    end

    def redirect_url(status, order)
      if order.complete?
        return spree.order_url(order, :token => order.token)
      end

      failed_url
    end

    def verification_details
      ::SagePay::Server::SignatureVerificationDetails.new(
        payment_method.preferred_vendor,
        payment_source.security_key
      )
    end
  end
end
