class Spree::Calculator::Ups::LmmBase < Spree::Calculator
  
  # max weight that a package can contain
  def self.max_weight
    150
  end
  
  def compute(object)
    if object.is_a?(Array)
      order = object.first.order
    elsif object.is_a?(Shipment)
      order = object.order
    else
      order = object
    end
    origin= Location.new(:country => Spree::ActiveShipping::Config[:origin_country],
                         :city => Spree::ActiveShipping::Config[:origin_city],
                         :state => Spree::ActiveShipping::Config[:origin_state],
                         :zip => Spree::ActiveShipping::Config[:origin_zip])

    addr = order.ship_address

    destination = Location.new(:country => addr.country.iso,
                               :state => (addr.state ? addr.state.abbr : addr.state_name),
                               :city => addr.city,
                               :zip => addr.zipcode)

    rates = Rails.cache.fetch(cache_key(order)) do
      rates = retrieve_rates(origin, destination, packages(order))
    end

    return nil if rates.empty?
    rate = rates[self.class.description]
    return nil unless rate
    rate = rate.to_f + (Spree::ActiveShipping::Config[:handling_fee].to_f || 0.0)

    # divide by 100 since active_shipping rates are expressed as cents
    return rate/100.0
  end
  
  # Generates an array of Package objects based on the quantities and weights of the variants in the line items
  def packages(order)
    multiplier = Spree::ActiveShipping::Config[:unit_multiplier]
    packages = Array.new
    value = 0
    # loop through the line items
    for line_item in order.line_items
      # loops through the quantity to determine the amount of packages needed.
      line_item.quantity.times do |i|
        # create new package if weight is over amount
        if line_item.variant.weight < 151  then
          if (value + (line_item.variant.weight ? (line_item.variant.weight * multiplier) : 0)) > (max_weight * multiplier) then
            packages[packages.length] = Package.new(value, [], :units => Spree::ActiveShipping::Config[:units].to_sym)
            value = 0
          end  
          # add to total weight of packag
          value += line_item.variant.weight ? (line_item.variant.weight * multiplier) : 0
        end
      end 
    end
    packages[packages.length] = Package.new(value, [], :units => Spree::ActiveShipping::Config[:units].to_sym)

    packages
  end
end