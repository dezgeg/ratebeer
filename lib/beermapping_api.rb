class BeermappingApi
  def self.places_in(city)
    api_key = ENV['BEERMAPPING_API_KEY']
    url = "http://beermapping.com/webservice/loccity/#{api_key}"

    response = HTTParty.get "#{url}/#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    if places.is_a?(Hash) and places['id'].nil?
      places = []
    end

    places = [places] if places.is_a?(Hash)
    return places.inject([]) do |set, location|
      set << Place.new(location)
    end
  end
end
