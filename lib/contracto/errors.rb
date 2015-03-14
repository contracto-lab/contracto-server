class Contracto::CouldNotDownloadContractError < StandardError
  def initialize(repo_url)
    super "Could not download contract from: \"#{repo_url}\""
  end
end