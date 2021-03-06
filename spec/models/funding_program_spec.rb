# frozen_string_literal: true

require "rails_helper"

RSpec.describe Vocabulary::FundingProgram do
  subject { Vocabulary::FundingProgram.new(name: "Funding Program", eid: "funding_program-fp") }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:eid) }
end
