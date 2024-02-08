require 'test_helper'
require 'mocha/minitest'

class GoodOrderProcessorTest < ActiveSupport::TestCase
  test "#process returns a success object" do
    # Set the DB scene
    user = create_user
    book = create_book
    order = create_order(user: user, book: book)

    # Define dependencies
    payment_processor_stub = mock('payment_processor')
    shipping_service_stub = mock('shipping_service')
    payment_processor_stub.stubs(:process_payment).with(order).returns(true)
    shipping_service_stub.stubs(:schedule_delivery).with(order).returns(true)

    # Do the work
    order_processor = OrderProcessor.new(payment_processor_stub, shipping_service_stub)
    result = order_processor.process(order)

    # Inspect the outcome
    assert_predicate result, :success?
  end

  test "#process marks order as completed" do
    # Set the DB scene
    user = create_user
    book = create_book
    order = create_order(user: user, book: book, status: 'pending')

    # Define dependencies
    payment_processor_stub = mock('payment_processor')
    shipping_service_stub = mock('shipping_service')
    payment_processor_stub.stubs(:process_payment).with(order).returns(true)
    shipping_service_stub.stubs(:schedule_delivery).with(order).returns(true)

    # Do the work
    order_processor = OrderProcessor.new(payment_processor_stub, shipping_service_stub)
    order_processor.process(order)

    # Inspect the work
    assert_predicate order, :completed?
  end
end
