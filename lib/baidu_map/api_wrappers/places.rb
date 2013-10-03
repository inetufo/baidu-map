module BaiduMap

  class Places
    
    include BaseNetMethods
    extend Forwardable
    def_delegators :@options, :key, :keyword, :radius, :page_size, :page_num

    attr_reader :lat, :lng
        
    def initialize(lat, lng, options = {})
      @lat, @lng = lat, lng
      options[:key]  ||= key
      options[:keyword]  ||= keyword
      options[:radius]  ||= 1000
      options[:page_size]  ||= 10
      options[:page_num]  ||= 1
      @options = OpenStruct.new options
    end
    
    def get
      parsed_response["results"].inject([]) do |memo, result|
        memo << {
            :name => result["name"],
            :address => result["address"],
            :lat => result["location"]["lat"],
            :lng => result["location"]["lng"],
            :name => result["name"],
            :full_data => result
        }
      end
    end
    
    private
    
    def base_request
      req = "http://api.map.baidu.com/place/v2/eventsearch?query=#{keyword}&event=groupon&location=#{lat},#{lng}&radius=#{radius}&output=json&page_size=#{page_size}&page_num=#{page_num}&ak=#{key}"
      req
    end
    
    def valid_position?
      !(lat.nil? || lng.nil?)
    end
    
    def raise_invalid
      raise BaiduMap::PlacesInvalidQuery, "You must provide at least a lat/lon for a Google places query"
    end
    
    def raise_missing_key
      raise "Baidu Places API requires an API key"
    end
    
    def raise_net_status
      raise BaiduMap::PlacesNetStatus, "The request sent to google was invalid (not http success): #{base_request}.\nResponse was: #{response}"
    end
    
    def raise_query_error
      raise BaiduMap::PlacesStatus, "The address you passed seems invalid, status was: #{parsed_response["status"]}.\nRequest was: #{base_request}"
    end
    
    def get_response
      open(base_url).read
    end
    
  end
end