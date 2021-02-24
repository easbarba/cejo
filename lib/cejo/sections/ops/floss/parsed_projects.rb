
require "yaml"

module Cejo
  module Ops
    module Floss
      # Good
      class Parsed_Projects
        attr_reader :folder

        def initialize(folder)
          @folder = folder.join("floss")
        end

        # Parse FLOSS files
        def parse_floss_projects
          projects = {}

          folder.each_child do |file|
            name = file.basename.sub_ext("").to_s
            projects[name] = YAML.load_file file # instead load per time to avoid errors; enumerator?
          end

          projects
        end
      end
    end
  end
end
