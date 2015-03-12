require "contracto/version"

module Contracto
  GEM_DIR = Gem::Specification.find_by_name('contracto').gem_dir

  require 'contracto/installer'
end
