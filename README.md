# Cejo
  Miscellaneous Unix automation and services utilities

# Sections

## Ops
   Front-end of system utilities, services and programs.

## Media
   Manage and grab media.

## Projects
   Install local builds of FLOSS Projects.

## Distro
   An one-do-it-all porcelain front-end of the most used Distro Linux package managers.

## Features
	For more information on each sections features, please refer to `cejo --help`.

# Install

## rubygems
```sh
gem install cejo
```

## local
```sh
rake install
```

## Container
```sh
podman build -t cejo .
```

# Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).


# Running

## local
```sh
cejo
```

## Container
```sh
podman run -it cejo cejo
```

# Why Cejo?
A humble tribute to my beloved grandparents: Celina & Joseph.

# License
  GPL version 3
