require 'thor'

module Rbdash
  class CLI < Thor
    include Thor::Actions

    desc 'init', 'create a configuration file.'
    def init
      create_file 'config.yml' do
        base_uri = ask('Type your redash server uri:')
        token = ask('Type your redash API token:')
        "base_uri: #{base_uri}\ntoken: #{token}"
      end
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
