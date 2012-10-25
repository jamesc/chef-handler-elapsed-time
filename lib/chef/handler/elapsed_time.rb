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
        max_time = all_resources.max_by{ |r| r.elapsed_time}.elapsed_time
        longest_resource_name = all_resources.max_by{ |r| full_name(r).length}
        max_resource_length = full_name(longest_resource_name).length
        Chef::Log.info "%-#{max_resource_length}s  Elapsed Time(%.2fs per unit)"%["Resource", max_time]
        Chef::Log.info "%-#{max_resource_length}s  %s"%["========", "============"]
        all_resources.each do |r|
          char = if r.updated then "+" else "-" end
          bar = char * ( @config[:max_width] * (r.elapsed_time/max_time))
          Chef::Log.info "%-#{max_resource_length}s  %s"%[full_name(r), bar]
        end
        Chef::Log.info ""
        Chef::Log.info " * '+' denotes a resource which updated this run"
        Chef::Log.info " * '-' denotes a resource which did not update this run"
      end

    end

    def full_name(resource)
      "#{resource.resource_name}[#{resource.name}]"
    end
  end
end
