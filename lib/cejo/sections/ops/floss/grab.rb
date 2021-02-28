# frozen_string_literal: true

require 'git'

module Cejo
  module Ops
    module Floss
      # Grab FLOSS Projects
      class Grab
        attr_reader :utils, :folder, :url

        def initialize(utils, folder, url)
          @utils = utils
          @folder = folder
          @url = url
        end

        def do_pull
          utils.spin("Pulling") do
            repo = Git.open(folder)
            repo.pull("origin", repo.current_branch)
          end
        end

        def do_clone
          utils.spin("Cloning") do
            Git.clone(url, folder)
          end
        end

        # Cloning/Pulling FLOSS Project
        def grab_this
          if folder.exist?
            do_pull
          else
            do_clone
          end
        end
      end
    end
  end
end
