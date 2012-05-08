class Calculator::Ups::LmmNextDayAir < Calculator::Ups::LmmBase
  def self.description
    "UPS Next Day Air"
  end
  
  def max_weight
    150
  end
end