require_relative 'weather_provider_current_day'

class WeatherReporter
  DEFAULT_CITY = 'Berlin'

  attr_reader :city, :degrees

  def initialize(city: DEFAULT_CITY, degrees: :c)
    @city = city
    @degrees = degrees
  end

  def call
    data = WeatherProviderCurrentDay.new(city: city).get_weather
    print_report(data)
  end

  private

  def print_report(data)
    puts "Current temp in #{data[:region]} is #{data[:currentConditions][:temp][degrees]}#{degrees.upcase}."
  end
end