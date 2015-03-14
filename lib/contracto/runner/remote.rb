class Contracto::Runner::Remote < Contracto::Runner::Base
  require 'fileutils'

  def execute
    puts 'downloading contract...'
    clone_repo || raise(Contracto::CouldNotDownloadContractError.new(server_repo_url))
    mv_repo_files_to_current_dir
    remove_old_repo_dir
    start_server
  end

  private

  def clone_repo
    system "git clone -q  --depth 1 --single-branch --branch master #{server_repo_url} #{tmp_dir}"
  end

  def mv_repo_files_to_current_dir
    system "mv #{tmp_dir}/* #{tmp_dir}/.[^.]* . 2> /dev/null"  # Could not use FileUtils for some reason
  end

  def remove_old_repo_dir
    FileUtils.rm_rf tmp_dir
  end

  def tmp_dir
    Contracto::CONTRACTO_TMP_DIR
  end
end
