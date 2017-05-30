module Rbdash
  class CLI::Push
    def run(id)
      Rbdash::Models::Query.update(id)
      puts 'complete!'
    end
  end
end
