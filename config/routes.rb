Spree::Core::Engine.routes.draw do
  scope :sagepay do
    post :notification, to: 'sagepay#notification', as: 'sagepay_notification'
    get :redirect, to: 'sagepay#redirect', as: 'sagepay_redirect'
  end
end
