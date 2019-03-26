# frozen_string_literal: true

require "rails_helper"

RSpec.describe Filter do
  class MyFilter < Filter
    def initialize(params = {})
      super(params: params.fetch(:params, {}),
            field_name: "my_filter", type: :select,
            title: "My Filter")
    end

    protected

      def fetch_options
        unless @my_options
          @my_options = [["A", "1", 1], ["B", "2", 2]]
        else
          raise "boom! fetching options for the second time"
        end
      end

      def do_call(services)
        services.select { |s| s == value }
      end
  end

  context "#options" do
    it "returns filter select options" do
      filter = MyFilter.new

      expect(filter.options).to contain_exactly(["A", "1", 1], ["B", "2", 2])
    end
    it "are cached" do
      filter = MyFilter.new

      filter.options
      filter.options
    end
  end

  context "#call" do
    it "is invoked when filter is active" do
      filter = MyFilter.new(params: { "my_filter" => "s2" })

      expect(filter.call(["s1", "s2"])).to contain_exactly("s2")
    end

    it "returns all records when filter is not active" do
      filter = MyFilter.new

      expect(filter.call(["s1", "s2"])).to eq(["s1", "s2"])

    end
  end

  context "#active_filters" do
    it "returns list of active filters when params are a list" do
      params = ActionController::Parameters.new("my_filter" => ["1", "2"])
      filter = MyFilter.new(params: params)

      expect(filter.active_filters).
        to contain_exactly(["A", anything], ["B", anything])
    end

    it "returns one active filter when param is a value" do
      params = ActionController::Parameters.new("my_filter" => "1")
      filter = MyFilter.new(params: params)

      expect(filter.active_filters).
        to contain_exactly(["A", anything])
    end

    it "ignores non existing filter values" do
      params = ActionController::Parameters.new("my_filter" => "non-existing")
      filter = MyFilter.new(params: params)

      expect(filter.active_filters).to be_empty
    end

    it "removes itself from params list" do
      params = ActionController::Parameters.new("my_filter" => "1", "a" => "b")
      filter = MyFilter.new(params: params)

      expect(filter.active_filters).
        to contain_exactly(["A", "a" => "b"])
    end
  end
end