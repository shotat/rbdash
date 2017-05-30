require 'thor'

module Rbdash
  class CLI < Thor
    include Thor::Actions
    class_option 'dry-run'

    desc 'init', 'pulls existing configurations.'
    def init
      CLI::Init.new.run
    end

    desc 'pull', 'pulls existing configurations.'
    def pull
      CLI::Pull.new.run
    end

    desc 'push <id>', 'push configurations'
    def push(_id)
      CLI::Push.new.run
    end
  end
end
