# frozen_string_literal: true

module Cejo
  class Hives
    attr_reader :services, :arguments, :argument, :folders, :utils

    def initialize(services, arguments)
      @services = services
      @arguments = arguments if arguments
      @argument = arguments.first if arguments
      @utils = services.resolve(:utils)
      @folders = services.resolve(:folders)
    end

    def ops
      {
        brightness: Ops::Brightness.new(utils, argument),
        dots: Ops::Dots.new(utils, argument),
        volume: Ops::Volume.new(utils, argument),
        screenshot: Ops::Screenshot.new(utils, argument.to_sym),
        sysinfo: Ops::Sysinfo.new(utils, argument),
        homey: Ops::Homey.new(argument),
      }
    end

    def projects
      {
        dwm: Projects::Dwm.new(services),
        emacs: Projects::Emacs.new(services),
        ruby: Projects::Ruby.new(services),
        st: Projects::St.new(services),
      }
    end

    def floss
      {
        archive: Floss::Core.new(folders, utils, :archive),
        grab: Floss::Core.new(folders, utils, :grab),
      }
    end

    def distro
      {
        install: Distro::Base.new(folders, utils, arguments, :install),
        remove: Distro::Base.new(folders, utils, arguments, :remove),
        upgrade: Distro::Base.new(folders, utils, arguments, :upgrade),
        update: Distro::Base.new(folders, utils, arguments, :update),
        autoremove: Distro::Base.new(folders, utils, arguments, :autoremove),
        clean: Distro::Base.new(folders, utils, arguments, :clean),
        search: Distro::Base.new(folders, utils, arguments, :search),
        download: Distro::Base.new(folders, utils, arguments, :download),
        installed: Distro::Base.new(folders, utils, arguments, :installed),
        fix: Distro::Base.new(folders, utils, arguments, :fix),
      }
    end

    def media
      {
        play: Media::Play.new(argument),
        get: Media::Get.new(arguments),
      }
    end

    public

    # Return available sections.
    def sections
      {
        media: media,
        ops: ops,
        projects: projects,
        distro: distro,
        floss: floss
      }
    end
  end
end
