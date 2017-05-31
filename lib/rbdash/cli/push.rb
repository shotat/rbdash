require 'diffy'
module Rbdash
  class CLI::Push

    def run(*ids)
      ids.each do |id|
        show_diff(id)
        update(id)
      end
    end

    def dry_run(*ids)
      ids.each do |id|
        show_diff(id)
      end
    end

    private

    def update(id)
      Rbdash::Models::Query.update(id)
    end

    def show_diff(id)
      remote_state = Rbdash::Models::Query.find(id)
      local_state = Rbdash::Models::Query.load(id)
      puts Diffy::Diff.new(remote_state.to_json, local_state.to_json, diff_opt).to_s(:color)
    end

    def diff_opt
      { include_diff_info: true, context: 2 }
    end
  end
end
