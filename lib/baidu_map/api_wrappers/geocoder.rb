module BaiduMap

  class Geocoder
    include BaseNetMethods

    attr_reader :address, :language, :raw, :protocol

    def initialize(address, city, options = {})
      raise BaiduMap::GeocodeInvalidQuery, "You must provide an address" if address.blank?

      @address, @city = address, city
      options[:key]  ||= key
      @options = OpenStruct.new options
    end

    # returns an array of hashes with the following keys:
    # - lat: mandatory for acts_as_gmappable
    # - lng: mandatory for acts_as_gmappable
    # - matched_address: facultative
    # - bounds:          facultative
    # - full_data:       facultative
    def get_coordinates
      parsed_response["result"].inject([]) do |memo, result|
        memo << {
            :lat => result["location"]["lat"],
            :lng => result["location"]["lng"],
            :full_data => result
        }
      end
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
