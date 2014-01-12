module VagrantPlugins
  module HostRubyProvisioner
    class Provisioner < Vagrant.plugin '2', :provisioner
      def _execute_code
        @config.routine.call
      end

      def cleanup
        @config.clean.call
      end

      def provision
        if @config.cwd
          Dir.chdir @config.cwd, &(method :_execute_code)
        else
          _execute_code
        end
      end
    end
  end
end