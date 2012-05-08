class Calculator::Lmm::NoShippingCalculation < Spree::Calculator
 def self.description
   "Spree Will Not Calculate Shipping"
 end

 def compute(object)
   0
 end

end