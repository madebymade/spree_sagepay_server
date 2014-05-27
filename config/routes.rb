Spree::Core::Engine.routes.append do
  match '/sagepay/notification', :to => "sagepay#notification", :as => 'sagepay_notification', :via => [:post]
  match '/sagepay/redirect',     :to => "sagepay#redirect",     :as => 'sagepay_redirect',     :via => [:get]
end
