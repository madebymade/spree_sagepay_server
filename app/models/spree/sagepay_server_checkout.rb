module Spree
  class SagepayServerCheckout < ActiveRecord::Base
    has_many :payments, as: :source, class_name: 'Spree::Payment'
  end
end
