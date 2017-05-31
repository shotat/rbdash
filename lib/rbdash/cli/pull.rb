module Rbdash
  class CLI::Pull
    def run(*ids, **options)
      # find remote queries
      queries = if options[:is_all]
                  Rbdash::Models::Query.find_all
                else
                  ids.map do |id|
                    Rbdash::Models::Query.find(id)
                  end
                end
      # save
      queries.each do |query|
        show_diff(query)
        next if options[:is_dry]

        # update local states
        query.save
      end
    end

    private

    def show_diff(query)
      id = query.body['id']
      local_state = Rbdash::Models::Query.load(id)
      diff = Diffy::Diff.new(local_state.to_json, query.to_json, diff_opt).to_s(:color)
      puts diff unless diff.chomp.empty?
    end

    def diff_opt
      { include_diff_info: true, context: 2 }
    end
  end
end
