module Contracto::Constants
  require 'fileutils'
  
  GEM_DIR               = Gem::Specification.find_by_name('contracto').gem_dir
  ROOT_DIR              = FileUtils.pwd
  CONTRACTO_DIR         = '.contracto'
  CONTRACTO_TMP_DIR     = '.tmp.contracto'
  RUBY_SERVER_DIR       = "#{GEM_DIR}/lib/contracto/server/ruby"
  CONTRACT_FILENAME     = 'contract.con.json'   # TODO: remove
  SAMPLE_CONTRACT_DIR   = "#{GEM_DIR}/spec/fixtures"
  SERVER_PIDFILE_NAME   = 'server'
  SERVER_PIDFILE_PATH   = "#{ROOT_DIR}/#{SERVER_PIDFILE_NAME}.pid"
  PORT                  = 54321

  %w(
    gem_dir
    root_dir
    contracto_dir
    contracto_tmp_dir
    sample_contract_dir
    contract_filename
    server_pidfile_name
    server_pidfile_path
    port
  ).each do |method_name|
    define_method method_name do
      Contracto::Constants.const_get method_name.upcase
    end
  end

end