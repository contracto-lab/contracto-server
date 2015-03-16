require 'fileutils'

class Contracto::Command::Init
  def initialize(args)
  end

  def execute
    remove_old_dir
    cp_server_files
    if contract_already_exists?
      remove_sample_contract_file
    else
      create_contract
    end
    puts 'contracto initialized'
    puts "start writing contracts in #{Contracto::CONTRACT_FILENAME}"
  rescue
    revert
  end

  private

  def remove_old_dir
    FileUtils.rm_rf Contracto::CONTRACTO_DIR
  end

  def cp_server_files
    FileUtils.cp_r Contracto::RUBY_SERVER_DIR, Contracto::CONTRACTO_TMP_DIR
    FileUtils.mv Contracto::CONTRACTO_TMP_DIR, Contracto::CONTRACTO_DIR
  end

  def create_contract
    FileUtils.mv sample_contract_path, FileUtils.pwd
    puts "created: #{installer.CONTRACT_FILENAME}"
  end

  def contract_already_exists?
    File.exist? Contracto::CONTRACT_FILENAME
  end

  def remove_sample_contract_file
    FileUtils.rm sample_contract_path
  end

  def sample_contract_path
    "#{Contracto::CONTRACTO_DIR}/#{Contracto::CONTRACT_FILENAME}"
  end

  def revert
    # TODO: implement
  end
end
