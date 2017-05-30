module Rbdash
  class CLI::PushAll
    def run
      ids = Dir.glob('queries/*').map do |f|
        f.match(/\d+/)[0]
      end
      ids.each.map do |id|
        Rbdash::Models::Query.update(id)
      end
    end
  end
end

