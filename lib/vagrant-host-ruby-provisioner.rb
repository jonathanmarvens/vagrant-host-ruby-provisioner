require 'pathname'
require 'vagrant-host-ruby-provisioner/plugin'

module VagrantPlugins
  module HostRubyProvisioner
    class << self
      attr_reader :source_root

      def source_root
        Pathname.new File.expand_path '..', (File.dirname __FILE__)
      end
    end
  end
end