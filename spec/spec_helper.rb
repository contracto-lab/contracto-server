require_relative '../lib/contracto'

STRINGS_WITH_JSON = [File.read('spec/fixtures/contract.con.json')]

RSpec.configure do |config|
  config.before(:each) do
    allow_any_instance_of(Contracto::Constants).to receive(:root_dir).and_return FileUtils.pwd + '/spec/fixtures'
  end
end
