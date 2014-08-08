# Chef Handler for logging resource execution time as an ascii
# barchart
#
# Author:: James Casey <jamesc.000@gmail.com>
# Copyright:: Copyright 2012 Opscode, Inc.
# License:: Apache2
#


class Chef
  class Handler
    class ElapsedTime < Chef::Handler

      def initialize(config={})
        @config = config
        @config[:max_width] ||= 30
        @config
      end

      def report
        @max_time = all_resources.max_by{ |r| r.elapsed_time}.elapsed_time
        @max_resource = all_resources.max_by{ |r| full_name(r).length}
        Chef::Log.info "%-#{max_resource_length}s  %s"%["Resource", "  Elapsed Time"]
        Chef::Log.info "%-#{max_resource_length}s  %s"%["========", "  ============"]
        all_resources.each do |r|
          char = if r.updated then "+" else "-" end
          bar = "#{char} " + char * ( @config[:max_width] * (r.elapsed_time/@max_time))
          Chef::Log.info "%-#{max_resource_length}s  %s"%[full_name(r), bar]
        end
        Chef::Log.info ""
        Chef::Log.info "Slowest Resource : #{full_name(@max_resource)} (%.6fs)"%[@max_time]
        Chef::Log.info "Scale            : %.6fs per unit width"%[unit_width]
        Chef::Log.info " * '+' denotes a resource which updated this run"
        Chef::Log.info " * '-' denotes a resource which did not update this run"
      end

    end

    def unit_width
      @max_time/@config[:max_width]
    end

    def max_resource_length
      full_name(@max_resource).length
    end

    def full_name(resource)
      "#{resource.resource_name}[#{resource.name}]"
    end
  end
end
