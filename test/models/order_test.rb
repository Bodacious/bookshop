require "test_helper"

class OrderTest < ActiveSupport::TestCase
  test '.completed includes Orders that have status completed' do
    # Set the DB scene
    user = create_user
    book = create_book
    completed_order = create_order(status: 'completed', user: user, book: book)

    assert_includes Order.completed, completed_order
  end

  test '.completed excludes Orders that have status pending' do
    # Set the DB scene
    user = create_user
    book = create_book
    pending_order = create_order(status: 'pending', user: user, book: book)

    refute_includes Order.completed, pending_order
  end

  test '#completed? returns true if Order status is completed' do
    order = Order.new(status: 'completed')

    assert_predicate order, :completed?
  end

  test '#completed? returns false if Order status is pending' do
    order = Order.new(status: 'pending')

    refute_predicate order, :completed?
  end
end
