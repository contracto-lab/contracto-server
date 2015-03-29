require 'spec_helper'

RSpec.describe Contracto::Contract do

  context '#http_method' do
    let(:contract) { contracts[1] }
    subject { contract.http_method }

    it { expect(subject).to eq 'get' }
  end

  context '#url_pattern' do
    let(:contract) { contracts[1] }
    subject { contract.url_pattern }

    it { expect(subject).to eq '/users/:id' }
  end

  def contracts
    Contracto::Parser.new(STRINGS_WITH_JSON).contracts
  end

end