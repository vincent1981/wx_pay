module WxPay::Result < ::Hash
  SUCCESS_FLAG = 'SUCCESS'.freeze

  def initialize(attribute)
    @attribute = attribute
  end
    
  end
  
end