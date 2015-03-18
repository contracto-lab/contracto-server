require_relative 'contracto/version' # TODO: replace all #require with #require_relative

module Contracto
  require_relative 'contracto/errors'
  require_relative 'contracto/constants'
  require_relative 'contracto/config'
  require_relative 'contracto/contract'
  require_relative 'contracto/parser'
  require_relative 'contracto/system_action'
  require_relative 'contracto/command'
end
