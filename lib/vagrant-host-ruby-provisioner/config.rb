require 'vagrant-host-ruby-provisioner/info'

module VagrantPlugins
  module HostRubyProvisioner
    class Config < Vagrant.plugin '2', :config
      attr_accessor :clean
      attr_accessor :cwd
      attr_accessor :routine

      def initialize
        @clean   = UNSET_VALUE
        @cwd     = UNSET_VALUE
        @routine = UNSET_VALUE
      end

      def finalize!
        if @clean == UNSET_VALUE
          @clean = lambda {}
        end

        if @cwd == UNSET_VALUE
          @cwd = nil
        end

        if @routine == UNSET_VALUE
          @routine = lambda {}
        end
      end

      def validate machine
        errors  = _detected_errors
        results = {}

        if ! @clean.lambda?
          errors << (I18n.t :'vagrant_host_ruby_provisioner.config.clean.not_lambda')
        end

        if ! @routine.lambda?
          errors << (I18n.t :'vagrant_host_ruby_provisioner.config.routine.not_lambda')
        end

        results[HostRubyProvisioner::INFO[:name]] = errors

        results
      end
    end
  end
end