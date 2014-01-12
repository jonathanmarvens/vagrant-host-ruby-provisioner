($:).unshift File.expand_path '../lib', __FILE__

require 'vagrant-host-ruby-provisioner/info'
require 'vagrant-host-ruby-provisioner/version'

Gem::Specification.new do |spec|
  spec.authors      = 'Jonathan Barronville'
  spec.description  = VagrantPlugins::HostRubyProvisioner::INFO[:description]
  spec.email        = 'jonathan.barronville@jebbit.com'
  spec.homepage     = 'https://github.com/jonathanmarvens/vagrant-host-ruby-provisioner'
  spec.license      = VagrantPlugins::HostRubyProvisioner::INFO[:license]
  spec.name         = VagrantPlugins::HostRubyProvisioner::INFO[:name_full_slug]
  spec.platform     = Gem::Platform::RUBY
  spec.require_path = 'lib'
  spec.summary      = VagrantPlugins::HostRubyProvisioner::INFO[:description]
  spec.version      = VagrantPlugins::HostRubyProvisioner::VERSION

  spec.add_dependency 'bundler', '~> 1.5.0'
  spec.add_dependency 'i18n', '~> 0.6.0'
  spec.add_development_dependency 'rake', '~> 10.1.0'

  spec.required_rubygems_version = '>= 2.0.0'

  ##################################################

  # Grab the name of the current directory.
  root_path = File.dirname __FILE__

  # Change to the current directory and get an array of all the files.
  all_files = Dir.chdir(root_path) { Dir.glob '**/*', File::FNM_DOTMATCH }

  # Remove the "." and ".." files from the array of all the files.
  all_files.reject! { |file_name| (['.', '..']).include? File.basename file_name }

  # Construct the ".gitignore" path.
  gitignore_path = File.join root_path, '.gitignore'

  # Grab the contents of the ".gitignore" file as an array.
  gitignore = IO.readlines gitignore_path

  # Strip the separator and unnecessary whitespace from each line of the ".gitignore" contents.
  gitignore.map! { |file_line| file_line.chomp.strip }

  # Remove any blank lines from the ".gitignore" contents.
  gitignore.reject! { |file_line| file_line.empty? }

  # Remove any lines that start with "#" or "!" from the ".gitignore" contents.
  gitignore.reject! { |file_line| file_line =~ /^(#|!)/ }

  all_files.reject! do |file_path|
    if File.directory? file_path
      next true
    else
      rejects = false

      rejects ||= gitignore.any? do |ignore_path_pattern|
        File.fnmatch(
          ignore_path_pattern,
          file_path,
          File::FNM_PATHNAME
        )
      end

      rejects ||= gitignore.any? do |ignore_path_pattern|
        File.fnmatch(
          ignore_path_pattern,
          File.basename(file_path),
          File::FNM_PATHNAME
        )
      end

      next rejects
    end
  end

  ##################################################

  spec.executables = (all_files.map { |file| file[/^bin\/(.*)/, 1] }).compact
  spec.files       = all_files
end