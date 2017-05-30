require 'thor'

module Rbdash
  class CLI < Thor
    include Thor::Actions
    class_option 'dry-run'

    desc 'pull', 'pulls existing configurations.'
    def pull
      puts 'pull.'
    end

    desc 'push <id>', 'push configurations'
    def push(id)
      puts 'push.'
    end
  end
end
