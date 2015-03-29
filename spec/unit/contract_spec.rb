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

  context '#response_body' do

    context 'by params' do

      let(:contract) { contracts[1] }
      let(:response_0) { JSON.parse contract.response_body('id' => '1', 'foo' => 'bar') }
      let(:response_1) { JSON.parse contract.response_body('id' => '2') }

      it 'should return body based on params' do
        expect(response_0).to eq('first_name' => 'Albert', 'last_name' => 'Einstein', 'age' => 30)
        expect(response_1).to eq('first_name' => 'Kurt', 'last_name' => 'Godel', 'age' => 35)
      end

      it 'should raise "ResponseNotFound" exception if no response matches params' do
        expect{ contract.response_body('id' => '-1') }.to raise_error(Contracto::ResponseNotFoundError)
      end
    end

  end

  def contracts
    Contracto::Parser.new(STRINGS_WITH_JSON).contracts
  end

end