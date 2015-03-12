require 'fileutils'

class Contracto::Installer::Local

  def execute
    remove_old_dir
    cp_server_files
    create_contract unless contract_already_exists?
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
    FileUtils.mv "#{Contracto::CONTRACTO_DIR}/#{Contracto::CONTRACT_FILENAME}", FileUtils.pwd
    puts "created: #{installer.CONTRACT_FILENAME}"
  end

  def contract_already_exists?
    File.exist? Contracto::CONTRACT_FILENAME
  end

  def revert
    # TODO: implement
  end
end
