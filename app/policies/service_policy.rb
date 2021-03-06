# frozen_string_literal: true

class ServicePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(status: [:published, :unverified, :errored])
    end
  end

  def show?
    record.published? || record.unverified? || record.errored?
  end

  def order?
    record.offers? && record.offers.any? { |s| s.published? }
  end

  def offers_show?
    record.offers_count > 1
  end

  def data_administrator?
    record.administered_by?(user)
  end
end
