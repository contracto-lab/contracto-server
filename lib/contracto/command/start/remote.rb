class Contracto::Command::Start::Remote
  def initialize(repo_url)
    Contracto::Config.repo_url = repo_url
  end

  def execute
    puts "downloading contract from #{Contracto::Config.repo_url} to #{Contracto::Config.root_dir}"
    Contracto::SystemActionChain.new(*actions).execute
  end

  private

  def actions
    [
      :clone_repo,
      :start_server
    ]
  end
end
