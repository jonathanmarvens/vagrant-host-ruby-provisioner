begin
  require 'vagrant'
rescue LoadError
  raise 'The Vagrant host Ruby provisioner must be run within Vagrant.'
end

if Vagrant::VERSION < '1.4.0'
  raise 'The Vagrant host Ruby provisioner is only compatible with Vagrant >= 1.4.0.'
end

require 'vagrant-host-ruby-provisioner/info'

module VagrantPlugins
  module HostRubyProvisioner
    class Plugin < Vagrant.plugin '2'
      name HostRubyProvisioner::INFO[:name_full_slug]
      description HostRubyProvisioner::INFO[:description]

      config :host_ruby, :provisioner do
        require_relative 'config'

        Config
      end

      provisioner :host_ruby do
        setup_i18n
        require_relative 'provisioner'

        Provisioner
      end

      class << self
        def setup_i18n
          I18n.load_path << (File.expand_path 'locales/en.rb', HostRubyProvisioner.source_root)

          I18n.reload!
        end
      end
    end
  end
end