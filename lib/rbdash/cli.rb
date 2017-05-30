require 'thor'

module Rbdash
  class CLI < Thor
    class_option 'dry-run'

    desc 'pull', 'pulls existing configurations.'

    def pull
      CLI::Pull.new.run
    end

    desc 'push <id>', 'push configurations'
    def push(id)
      CLI::Push.new.run(id)
    end

    desc 'push_all', 'push all configurations'
    def push_all
      CLI::PushAll.new.run
    end
  end
end
