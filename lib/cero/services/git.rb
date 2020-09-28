# frozen_string_literal: true

module Cero
  module Services
    # Git interface
    class Git
      ## clone project
      def clone(url, folder)
        system("git clone #{url} #{folder}")
      end

      ## pull project
      def pull(folder)
        system("git -C #{folder} pull")
      end

      # archive project
      def archive(repo, to)
        puts "Archiving: #{repo} to #{to}"
      end
    end
  end
end
