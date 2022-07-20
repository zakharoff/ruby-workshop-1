require 'date'

class WeatherPredicter
  DEFAULT_CITY = 'Berlin'
  DEFAULT_SOURCE = :random

  attr_reader :city, :source, :degrees, :method

  def initialize(city: DEFAULT_CITY, source: DEFAULT_SOURCE, degrees: :c, method: :avg)
    @city = city
    @source = source
    @degrees = degrees
    @method = method
  end

  def call
    return Random.rand(-40..40) if source == :random

    data = 'call weather provider(city, today, today - 10.years, source)'

    case method
    when :avg
      get_averange_temp(data)
    else
      # raise if not supported method
    end
  end

  private

  def get_averange_temp(data)
    # for example source as json from https://www.weatherbit.io/api/weather-history-daily
    today_m_d = Date.today.strftime('%m-%d')
    temps_history = []

    source[:data].each do |day|
      temps_history << day[:temp] if day[:datetime].include?(today_m_d)
    end

    temps_history.sum / temps_history.size
  end
end