Spree::Address.class_eval do
  def sage_pay_address
    require 'ostruct'

    OpenStruct.new(
      :first_names => first_name,
      :surname => last_name,
      :address_1 => address1,
      :address_2 => address2,
      :city => city,
      :state => (state.try(:abbr) if state.present?),
      :post_code => zipcode,
      :country => country.try(:iso),
      :phone => phone
    )
  end
end
