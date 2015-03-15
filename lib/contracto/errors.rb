class Contracto::CouldNotDownloadContractError < StandardError
  def initialize(repo_url)
    super "Could not download contract from: \"#{repo_url}\""
  end
end

class Contracto::ServerAlreadyRunningError < StandardError
  def initialize
    super 'Could not start: Contracto server is already running'
  end
end
