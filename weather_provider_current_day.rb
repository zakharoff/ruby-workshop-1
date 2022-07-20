require 'net/http'
require 'json'

class WeatherProviderCurrentDay
  PATH = 'https://weatherdbi.herokuapp.com/data/weather'

  attr_reader :city

  def initialize(city:)
    @city = city
  end

  def get_weather
    response = Net::HTTP.get(URI("#{PATH}/#{city}"))
    # raise if bad response
    JSON.parse(response, symbolize_names: true)
  end
end