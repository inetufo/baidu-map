require 'net/http'
require 'uri'
require 'json'
require 'ostruct'

module BaiduMap

  autoload :BaseNetMethods,   'baidu-map/api_wrappers/base_net_methods'
  autoload :Geocoder,         'baidu-map/api_wrappers/geocoder'
  autoload :Places,           'baidu-map/api_wrappers/places'

  def BaiduMap.geocode(address, city, key)
    ::BaiduMap::Geocoder.new(address, city, {
      :key => key
    }).get_coordinates
  end
  
  def BaiduMap.places(lat, lng, region, key, keyword = nil, radius = 1000, page_size = 10, page_num = 1)
    BaiduMap::Places.new(lat, lng, region, {
      :key      => key,
      :keyword  => keyword,
      :radius   => radius, 
      :page_size => page_size,
      :page_num => page_num
    }).get
  end
  
  private
  
  class GeocodeStatus         < StandardError; end
  class GeocodeNetStatus      < StandardError; end
  class GeocodeInvalidQuery   < StandardError; end

  
  class PlacesStatus          < StandardError; end
  class PlacesNetStatus       < StandardError; end
  class PlacesInvalidQuery    < StandardError; end

end
