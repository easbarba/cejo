
require "yaml"

module Cejo
  module Ops
    module Floss
      # Good
      module Parsed_Projects
        # Parse FLOSS files
        def parse_floss_projects(cejo_config)
          floss_filepath = cejo_config.join("floss")
          projects = {}

          floss_filepath.each_child do |file|
            name = file.basename.sub_ext("").to_s
            projects[name] = YAML.load_file file # instead load per time to avoid errors; enumerator?
          end

          projects
        end
      end
    end
  end
end
