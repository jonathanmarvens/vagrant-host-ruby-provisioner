module VagrantPlugins
  module HostRubyProvisioner
    class Provisioner < Vagrant.plugin '2', :provisioner
      def _execute_clean
        @config.clean.call
      end

      def _execute_routine
        @config.routine.call
      end

      def cleanup
        if @config.cwd
          routine = method :_execute_clean

          Dir.chdir @config.cwd, &(proc { routine.call })
        else
          _execute_clean
        end
      end

      def provision
        if @config.cwd
          routine = method :_execute_routine

          Dir.chdir @config.cwd, &(proc { routine.call })
        else
          _execute_routine
        end
      end
    end
  end
end