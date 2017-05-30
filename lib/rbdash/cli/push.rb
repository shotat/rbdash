module Rbdash
  class CLI::Push
    def run(id)
      Rbdash::Models::Query.update(id)
    end
  end
end
