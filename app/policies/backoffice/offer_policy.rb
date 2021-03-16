# frozen_string_literal: true

class Backoffice::OfferPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.service_portfolio_manager?
        scope
      elsif user.service_owner?
        scope.joins(:service_user_relationships).
          where(service_user_relationships: { user: user })
      else
        Service.none
      end
    end
  end

  def new?
    (service_portfolio_manager? || record.service.owned_by?(user)) &&
      !service_deleted?
  end

  def create?
    managed? && !service_deleted?
  end

  def edit?
    managed? && !service_deleted?
  end

  def update?
    managed? && !service_deleted?
  end

  def destroy?
    managed? && orderless? && !service_deleted?
  end

  def publish?
    service_portfolio_manager? && record.draft? && !service_deleted?
  end

  def draft?
    service_portfolio_manager? && record.published? && !service_deleted?
  end

  def permitted_attributes
    [:id, :name, :description, :webpage, :order_type, :order_url, :internal,
     parameters_attributes: [:type, :name, :hint, :min, :max,
                             :unit, :value_type, :start_price, :step_price, :currency,
                             :exclusive_min, :exclusive_max, :mode, :values, :value]]
  end

  private
    def managed?
      service_portfolio_manager? ||
        record.service.owned_by?(user)
    end

    def service_portfolio_manager?
      user&.service_portfolio_manager?
    end

    def orderless?
      record.project_items.count.zero?
    end

    def service_deleted?
      record.service.deleted?
    end
end
