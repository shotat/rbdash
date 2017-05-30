require 'thor'

module Rbdash
  class CLI < Thor
    include Thor::Actions

    desc 'init', 'create a configuration file.'
    def init
      # create_file 'config.yml' do
        # jask('a')
        # "base_uri: #{a}"
      # end
    end

    desc 'pull', 'pulls existing configurations.'
    def pull
      CLI::Pull.new.run
    end

    method_option 'dry-run'
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
