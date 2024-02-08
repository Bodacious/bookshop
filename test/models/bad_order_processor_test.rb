require 'test_helper'

class BadOrderProcessorTest < ActiveSupport::TestCase
  test "#process returns a success object" do
    # Set the DB scene
    user = create_user
    book = create_book
    order = create_order(user: user, book: book, status: 'pending')

    # Initialize actual dependencies (BAD)
    payment_processor = PaymentProcessor.new
    shipping_service = ShippingService.new

    # Do the work
    order_processor = OrderProcessor.new(payment_processor, shipping_service)
    result = order_processor.process(order)

    # Inspect the outcome
    assert result.success?
  end

  test "#process marks Order as completed" do
    # Set the DB scene
    user = create_user
    book = create_book
    order = create_order(user: user, book: book, status: 'pending')

    # Initialize actual dependencies (BAD)
    payment_processor = PaymentProcessor.new
    shipping_service = ShippingService.new

    # Do the work
    order_processor = OrderProcessor.new(payment_processor, shipping_service)
    order_processor.process(order)

    # Inspect the outcome
    assert_predicate order.reload, :completed?
  end
end
