require 'thor'

module Rbdash
  class CLI < Thor
    include Thor::Actions
    OPT_DRY_RUN = 'dry-run'.freeze
    OPT_ALL = 'all'.freeze

    desc 'init', 'create a configuration file.'
    def init
      create_file '.rbdash.yml' do
        base_uri = ask('Type your redash server uri:')
        token = ask('Type your redash API token:')
        "base_uri: #{base_uri}\ntoken: #{token}"
      end
    end

    desc 'pull', 'pulls existing configurations.'
    method_option OPT_DRY_RUN
    method_option OPT_ALL
    def pull(*ids)
      if all? && !ids.empty?
        puts "'CONFLICT: Cannot assign ids with --#{OPT_ALL} option.'"
        return
      end
      CLI::Pull.new.run(*ids, command_options)
    end

    desc 'push <id1> <id2> ...', 'push configurations'
    method_option OPT_DRY_RUN
    method_option OPT_ALL
    def push(*ids)
      if all? && !ids.empty?
        puts "'CONFLICT: Cannot assign ids with --#{OPT_ALL} option.'"
        return
      end

      CLI::Push.new.run(*ids, command_options)
    end

    private

    def command_options
      { is_all: all?, is_dry: dry? }
    end

    def dry?
      options[OPT_DRY_RUN]
    end

    def all?
      options[OPT_ALL]
    end
  end
end
