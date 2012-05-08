class Calculator::Usps::LmmPriorityMailInternational <  Spree::Calculator
  def self.description
    "USPS Priority Mail"
  end
  
  def self.register
    super
    ShippingMethod.register_calculator(self)
  end
end