# frozen_string_literal: true

require 'git'

module Cejo
  module Ops
    module Floss
      # Grab FLOSS Projects
      class Grab
        attr_reader :services

        def initialize(services)
          @services = services
        end

        def do_pull(folder)
          services.spin("Pulling") do
            repo = Git.open(folder)
            repo.pull("origin", repo.current_branch)
          end
        end

        def do_clone(url, folder)
          services.spin("Cloning") { Git.clone(url, folder) }
        end

        # Cloning/Pulling FLOSS Project
        def grab_this(project)
          folder = project.folder
          url = project.url

          if folder.exist?
            do_pull folder
          else
            do_clone url, folder
          end
        end
      end
    end
  end
end
