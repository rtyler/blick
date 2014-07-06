require 'concurrent'
require 'blick/agent/observers'

module Blick
  module Agent
    class Scheduler
      attr_reader :tasks

      def initialize
        @tasks = {}
      end

      def run!
        prepare_tasks
        run_tasks
        nil
      end

      def stop!
        stop_tasks
        nil
      end

      private

      def prepare_tasks
        Blick::Agent::Observer.registry.each do |obs|
          next unless obs.enabled?

          tt = Concurrent::TimerTask.new(:execution_interval => obs.interval,
                                        :timeout_interval   => obs.interval) do
                                          begin
                                            obs.run!
                                          rescue StandardError => e
                                            puts "FAILURE #{e.inspect}"
                                          end
                                        end
          self.tasks[obs] = tt
        end
        return true
      end

      def run_tasks
        self.tasks.each_pair do |observer, task|
          task.execute
        end
      end

      def stop_tasks
        self.tasks.each_pair do |observer, task|
          puts "Shutting down #{observer}"
          task.shutdown
        end
        @tasks = {}
      end
    end
  end
end
