require 'fileutils'

class Contracto::Installer::Local

  def execute
    remove_old_dir
    cp_server_files
    create_contract unless contract_already_exists?
  rescue
    revert
  end

  private

  def remove_old_dir
    FileUtils.rm_rf installer::CONTRACTO_DIR
  end

  def cp_server_files
    FileUtils.cp_r installer::RUBY_SERVER_DIR, installer::CONTRACTO_TMP_DIR
    FileUtils.mv installer::CONTRACTO_TMP_DIR, installer::CONTRACTO_DIR
  end

  def create_contract
    FileUtils.mv "#{installer::CONTRACTO_DIR}/#{installer::CONTRACT_FILENAME}", FileUtils.pwd
    puts "created: #{installer.CONTRACT_FILENAME}"
  end

  def contract_already_exists?
    File.exist? installer::CONTRACT_FILENAME
  end

  def revert
    # TODO: implement
  end

  def installer
    Contracto::Installer
  end
end
