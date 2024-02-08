class OrderFulfillmentService
  attr_reader :order
  def self.call(order)
    new(order).call
  end

  private_class_method :new

  def initialize(order)
    @order = order
  end

  def call
    OrderProcessor.new(payment_processor, shipping_service).process(order)
  end

  private

  def shipping_service
    ShippingService.new
  end

  def payment_processor
    PaymentProcessor.new
  end
end