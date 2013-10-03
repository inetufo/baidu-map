require 'net/http'
require 'uri'
require 'json'
require 'ostruct'

module BaiduMap

  autoload :Geocoder,         'baidu_map/api_wrappers/geocoder'
  autoload :Places,           'baidu_map/api_wrappers/places'

  def BaiduMap.places(lat, lng, key, keyword = nil, radius = 1000, page_size = 10, page_num = 1)
    BaiduMap::Places.new(lat, lng, {
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
