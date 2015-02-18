module Spree
  class Admin::SagepayPaymentsController < Spree::Admin::BaseController
    before_filter :load_order

    def index
      @payments = @order.payments.includes(:payment_method)
        .where(spree_payment_methods: { type: 'Spree::Gateway::SagepayServer' })
    end

    private

    def load_order
      @order = Spree::Order.find_by(number: params[:order_id])
    end
  end
end
