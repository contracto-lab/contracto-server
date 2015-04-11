class Contracto::Command::Start::Remote
  def initialize(repo_url)
    Contracto::Config.repo_url = repo_url
  end

  def execute
    puts "downloading contract from #{Contracto::Config.repo_url}"
    Contracto::SystemActionChain.new(*actions).execute
  end

  private

  def actions
    [
      :clone_repo_to_tmp_contracto_dir,
      :move_tmp_dir_files_to_root_dir,
      :remove_tmp_contracto_dir,
      :start_server
    ]
  end
end
