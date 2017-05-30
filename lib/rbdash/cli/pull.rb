module Rbdash
  class CLI::Pull
    def run
      queries = Rbdash::Models::Query.find_all
      queries.each do |q|
        q.save
      end
    end
  end
end
