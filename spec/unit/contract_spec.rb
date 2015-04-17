require 'spec_helper'

RSpec.describe 'Contracto' do

  context 'HTTP methods' do
    it 'should return response with GET' do
      expect(get_users_call.data).to eq [{"first_name"=>"Albert", "last_name"=>"Einstein", "age"=>30}, {"first_name"=>"Kurt", "last_name"=>"Godel", "age"=>35}]
    end

    it 'should return response with POST' do
      # TODO
    end
  end

  context 'selecting response' do
    context 'by params' do
      it 'should find response by one string param' do
        expect(get_users_call(search: 'Albert').data).to eq [{"first_name"=>"Albert", "last_name"=>"Einstein", "age"=>30}]
      end

      it 'should find response by one integer param' do
        expect(get_users_by_id_call(id: 1).data).to eq("id"=>1, "first_name"=>"Albert", "last_name"=>"Einstein", "age"=>30)
      end

      it 'should find response by one hash param' do
        expect(post_users_call('user[first_name]' => 'New', 'user[last_name]' => 'User', 'user[age]' => '30').data).to eq("id"=>111, "first_name"=>"New", "last_name"=>"User", "age"=>30)
      end
    end

    context 'by headers' do
      it 'should find response by header' do
        expected = <<XML
<users type="array">
  <user>
    <id type="integer">1</id>
    <first-name>Albert</first-name>
    <last-name>Einstein</last-name>
    <age type="integer">30</age>
  </user>
  <user>
    <id type="integer">2</id>
    <first-name>Kurt</first-name>
    <last-name>Godel</last-name>
    <age type="integer">35</age>
  </user>
</users>
XML

        given = get_users_call.add_headers({"Content_Type" => "application/xml"}).body.gsub!(/\s+/, "")
        expected = expected.gsub!(/\s+/, "")
        expect(given).to eq expected
      end
    end
  end

end