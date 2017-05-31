require 'diffy'
module Rbdash
  class CLI::Push
    def run(*ids, **options)
      ids = Utils.find_local_ids if options[:is_all]
      ids.each do |id|
        show_diff(id)
        next if options[:is_dry]

        # update remote resources
        update(id)
      end
    end

    private

    def update(id)
      Rbdash::Models::Query.update(id)
    end

    def show_diff(id)
      remote_state = Rbdash::Models::Query.find(id)
      local_state = Rbdash::Models::Query.load(id)
      diff = Diffy::Diff.new(remote_state.to_json, local_state.to_json, diff_opt).to_s(:color)

      unless diff.chomp.empty?
        puts "[changed] #{id}"
        puts diff
      end
    end

    def diff_opt
      { include_diff_info: true, context: 2 }
    end
  end
end
