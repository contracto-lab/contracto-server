module Contracto::Constants
  require 'fileutils'
  
  GEM_DIR               = Gem::Specification.find_by_name('contracto').gem_dir
  ROOT_DIR              = FileUtils.pwd
  CONTRACTO_DIR         = '.contracto'
  CONTRACTO_TMP_DIR     = '.tmp.contracto'
  RUBY_SERVER_DIR       = "#{GEM_DIR}/lib/contracto/server/ruby"
  CONTRACT_FILENAME     = 'contract.con.json'
  CONTRACT_PID_FILEPATH = "#{CONTRACTO_DIR}/server.pid"
  PORT                  = 54321

  def gem_dir
    GEM_DIR
  end

  def root_dir
    ROOT_DIR
  end

  def contracto_dir
    CONTRACTO_DIR
  end

  def contracto_tmp_dir
    CONTRACTO_TMP_DIR
  end

  def ruby_server_dir
    RUBY_SERVER_DIR
  end

  def contract_filename
    CONTRACT_FILENAME
  end

  def contract_pid_filepath
    CONTRACT_PID_FILEPATH
  end

  def port
    PORT
  end
end