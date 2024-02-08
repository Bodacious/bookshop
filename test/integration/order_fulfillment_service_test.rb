require 'test_helper'

class OrderFulfillmentServiceTest < ActionDispatch::IntegrationTest
  test "OrderFulfillmentService completes order on success" do
    # Set the DB scene
    user = User.create!(name: "User Name", email: "user@example.com")
    book = Book.create!(title: "Book Title", author: "Author Name", price: 50)
    order = Order.create!(user: user, book: book, status: 'pending')

    assert_changes -> { Order.completed.count }, from: 0, to: 1 do
      OrderFulfillmentService.call(order)
    end
  end


  test "OrderFulfillmentService returns a success response on success" do
    # Set the DB scene
    user = User.create!(name: "User Name", email: "user@example.com")
    book = Book.create!(title: "Book Title", author: "Author Name", price: 50)
    order = Order.create!(user: user, book: book, status: 'pending')

    result = OrderFulfillmentService.call(order)

    assert_predicate result, :success?
    assert_predicate result.message, :present?
  end

  test "OrderFulfillmentService returns failed response  if exception occurs" do
    # Set the DB scene
    user = User.create!(name: "User Name", email: "user@example.com")
    book = Book.create!(title: "Book Title", author: "Author Name", price: 50)
    order = Order.create!(user: user, book: book, status: 'completed')

    result = OrderFulfillmentService.call(order)

    assert_predicate result, :failure?
    assert_equal result.message, 'Cannot complete Order that is already completed'
  end
end
