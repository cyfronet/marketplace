# frozen_string_literal: true

module Offerable
  extend ActiveSupport::Concern

  included do
    enum order_type: {
        open_access: "open_access",
        fully_open_access: "fully_open_access",
        order_required: "order_required",
        other: "other"
    }

    validates :order_type, presence: true
    validates :name, presence: true
    validates :description, presence: true

    def external
      order_required? && !internal
    end

    def open_access?
      order_type == "open_access" || order_type == "fully_open_access"
    end

    def order_required?
      order_type == "order_required"
    end

    def orderable?
      internal || (order_required? && !external)
    end
  end
end
