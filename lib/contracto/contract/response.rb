class Contracto::Contract::Response

  include Contracto::Constants

  def initialize(hash)
    @hash = hash
  end

  def params
    @hash.fetch('request')['params']  #TODO: should it be optional or required?
  end

  def body_path
    @hash.fetch('response').fetch('body_path')
  end

  def params_matches?(other_params)
    return true if params.nil?

    params.keys.all? do |key|
      other_params[key] == params[key].to_s
    end
  end

  def body
    File.read(root_dir + body_path)
  end
end
