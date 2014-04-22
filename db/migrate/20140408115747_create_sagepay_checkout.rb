class CreateSagepayCheckout < ActiveRecord::Migration
  def change
    unless Spree::SagepayServerCheckout.table_exists?
      create_table :spree_sagepay_server_checkouts do |t|
        t.string :vpstx_id
        t.string :security_key
      end
    end
  end
end
