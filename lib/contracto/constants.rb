module Contracto::Constants
  require 'fileutils'
  
  GEM_DIR               = Gem::Specification.find_by_name('contracto').gem_dir
  CURRENT_DIR           = FileUtils.pwd
  DEFAULT_ROOT_DIR      = CURRENT_DIR + '/.contract'
  CONTRACTO_DIR         = '.contracto'
  CONTRACTO_TMP_DIR     = '.tmp.contracto'
  RUBY_SERVER_DIR       = "#{GEM_DIR}/lib/contracto/server/ruby"
  CONTRACT_FILENAME     = 'contract.con.json'   # TODO: remove
  SAMPLE_CONTRACT_DIR   = "#{GEM_DIR}/spec/fixtures"
  SERVER_PIDFILE_NAME   = 'server'
  PORT                  = 54321

  %w(
    gem_dir
    current_dir
    default_root_dir
    contracto_dir
    contracto_tmp_dir
    sample_contract_dir
    contract_filename
    server_pidfile_name
    port
  ).each do |method_name|
    define_method method_name do
      Contracto::Constants.const_get method_name.upcase
    end
  end

end