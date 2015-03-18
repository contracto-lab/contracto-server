require 'spec_helper'

RSpec.describe Contracto::Parser do
  context '#contracts' do
    subject { described_class.new(STRINGS_WITH_JSON).contracts }

    it do
      expect(subject).to be_a Array
      expect(subject.first).to be_a Contracto::Contract
    end
  end
end