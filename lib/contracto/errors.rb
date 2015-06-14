require_relative 'errors/contract_not_found_error'
require_relative 'errors/response_not_found_error'

class Contracto::CouldNotDownloadContractError < StandardError
  def initialize(repo_url)
    super "Could not download contract from: \"#{repo_url}\""
  end
end

class Contracto::CouldNotStartServer < StandardError
end

class Contracto::ServerAlreadyRunningError < StandardError
  def initialize
    super 'Could not start: Contracto server is already running'
  end
end
