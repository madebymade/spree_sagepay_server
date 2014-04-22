Spree::Core::Engine.routes.append do
  match '/sagepay/notification', :to => "sagepay#notification", :as => 'sagepay_notification', :via => [:post]
end
