require 'thor'

module Rbdash
  class CLI < Thor
    include Thor::Actions

    desc 'init', 'create a configuration file.'
    def init
      create_file '.rbdash.yml' do
        base_uri = ask('Type your redash server uri:')
        token = ask('Type your redash API token:')
        "base_uri: #{base_uri}\ntoken: #{token}"
      end
    end

    desc 'pull', 'pulls existing configurations.'
    method_option 'dry-run'
    def pull
      CLI::Pull.new.run
    end

    desc 'push <id1> <id2> ...', 'push configurations'
    method_option 'dry-run'
    def push(*ids)
      if options['dry-run']
        CLI::Push.new.dry_run(*ids)
        return
      end
      CLI::Push.new.run(*ids)
    end

    desc 'push_all', 'push all configurations'
    method_option 'dry-run'
    def push_all
      CLI::PushAll.new.run
    end
  end
end
