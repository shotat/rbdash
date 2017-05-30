module Rbdash
  class CLI::Pull
    def run
      queries = Rbdash::Models::Query.find_all
      queries.each(&:save)
    end
  end
end
