# frozen_string_literal: true

module Cejo
  module Services
    # Git interface
    class Git
      private

      def git_it(command)
        system(command)
      end

      public

      ## clone project
      def clone(url, folder)
        git_it("git clone #{url} #{folder}")
      end

      ## pull project
      def pull(folder)
        git_it("git -C #{folder} pull")
      end

      ## archive project
      def archive(repo, to)
        puts "Archiving: #{repo} to #{to}"
      end
    end
  end
end
