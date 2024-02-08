class Order < ApplicationRecord
  STATUS_COMPLETED = 'completed'
  STATUS_PENDING = 'pending'

  belongs_to :user
  belongs_to :book

  scope :completed, -> { where(status: STATUS_COMPLETED) }

  def complete!
    raise StandardError, 'Cannot complete Order that is already completed' if completed?

    update_attribute!(:status, STATUS_COMPLETED)
  end

  def completed?
    status == STATUS_COMPLETED
  end

  def pending?
    status == STATUS_PENDING
  end
end
