class Contracto::SystemActionChain
  require_relative 'system_action'

  def initialize(*actions)
    @actions = actions
    @finished_actions = []
  end

  def execute
    perform_actions and true
  rescue StandardError => e
    revert_actions and false
    raise e
  end

  private

  def perform_actions
    @actions.each do |action|
      @finished_actions << action
      Contracto::SystemAction.send(action)
    end
  end

  def revert_actions
    @finished_actions.reverse.each do |action|
      revert_method_name = "revert_#{action}"
      if Contracto::SystemAction.respond_to? revert_method_name
        Contracto::SystemAction.send revert_method_name
      end
    end
  rescue StandardError
  end
end
