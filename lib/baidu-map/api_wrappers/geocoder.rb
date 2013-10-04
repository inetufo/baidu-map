module BaiduMap

  class Geocoder
    include BaseNetMethods
    extend Forwardable
    def_delegators :@options, :key
    attr_reader :address, :city

    def initialize(address, city, options = {})
      raise BaiduMap::GeocodeInvalidQuery, "You must provide an address" if address.blank?

      @address, @city = address, city
      options[:key]  ||= key
      @options = OpenStruct.new options
    end

    def get_coordinates
      result = parsed_response["result"]
      {
          :lat => result["location"]["lat"],
          :lng => result["location"]["lng"],
          :full_data => result
      }
    end

    private

    def base_request
      "http://api.map.baidu.com/geocoder?address=#{address}&output=json&key=#{key}&city=#{city}"
    end

    def raise_net_status
      raise BaiduMap::GeocodeNetStatus, "The request sent to baidu was invalid (not http success): #{base_request}.\nResponse was: #{response}"
    end

    def raise_query_error
      raise BaiduMap::GeocodeStatus, "The address you passed seems invalid, status was: #{parsed_response["status"]}.\nRequest was: #{base_request}"
    end

  end

end
