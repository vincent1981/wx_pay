#--
# wx sign algorithm function
#++

require 'digest/md5'

module WxPay
  module Sign
    SIGN_TYPE_MD5 = 'MD5'
    SIGN_TYPE_HMAC_SHA256 = 'HMAC-SHA256'
    class << self
      def generate(params, sign_type = SIGN_TYPE_MD5)
        key = params.delete(:key)

        query = params.sort.map do |k, v|
          "#{k}=#{v}" if v.to_s != ''
        end.compact.join('&')

        stringSignTemp="#{query}&key=#{key || WxPay.key}"

        if sign_type == SIGN_TYPE_MD5
          Digest::MD5.hexdigest(string_sign_temp).upcase
        elsif sign_type == SIGN_TYPE_HMAC_SHA256
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), key, string_sign_temp).upcase
        else
          warn("WxPay Warn: unknown sign_type : #{sign_type}")
        end
      end
    end
  end
end