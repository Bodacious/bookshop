class OrderProcessor
  attr_reader :payment_processor
  attr_reader :shipping_service

  Result = Data.define(:success, :message) do
    alias success? success
    def failure?
      !success?
    end
  end

  def initialize(payment_processor, shipping_service)
    @payment_processor = payment_processor
    @shipping_service = shipping_service
  end

  def process(order)
    if payment_processor.process_payment(order) && shipping_service.schedule_delivery(order)
      order.complete!
      Result.new(success: true, message: "Order processed successfully.")
    else
      Result.new(success: false, message: "Order processing failed.")
    end
  rescue StandardError => e
    Result.new(success: false, message: e.message)
  end
end
