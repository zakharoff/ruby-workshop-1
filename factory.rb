require_relative 'weather_predicter'

class PackedProduct
end

class IceCream < PackedProduct
  def initialize
    @package = FoilPackage.new
  end
end

class Package
  # cost, open
end

class FoilPackage < Package
end

class Factory
  PRODUCT_CLASS = nil

  attr_reader :produced_goods

  def initialize()
    @produced_goods = []
  end

  def produce!(quantity:, product_class:)
    batch = []

    quantity.times do
      batch << product_class.new
    end

    @produced_goods += batch
    batch
  end
end

class IceCreamFactory < Factory
  PRODUCT_CLASS = IceCream

  attr_reader :production_factor

  def initialize
    @production_factor = calculate_factor
    super
  end

  def produce!(quantity:)
    batch = []
    (quantity * production_factor).round.times do
      batch << PRODUCT_CLASS.new
    end

    @produced_goods += batch
    batch
  end

  private

  def calculate_factor
    forecast = WeatherPredicter.new.call

    if forecast > 30
      1.5
    elsif forecast < 10
      0.5
    else
      1      
    end
  end
end
