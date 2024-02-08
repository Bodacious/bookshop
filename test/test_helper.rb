ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require 'mocha/minitest'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    #
    def create_order(**attributes)
      default_attributes = {
        status: "pending"
      }
      Order.create!(default_attributes.merge(attributes))
    end

    def create_user(**attributes)
      default_attributes = { name: "User name" }
      User.create!(default_attributes.merge(attributes))
    end

    def create_book(**attributes)
      default_attributes = { title: "Book title", author: "Author name", price: 10.0 }
      Book.create!(default_attributes.merge(attributes))
    end
  end
end
