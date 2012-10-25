chef-handler-elapsed-time
=========================

A chef handler that reports on per-resource elasped times in a simple graphical form.

Requirements
============

Only works on Chef >= 10.14

Usage
=====

Use the
[chef_handler cookbook by Opscode](http://community.opscode.com/cookbooks/chef_handler).
Create a recipe with the following:

    include_recipe "chef_handler"

    # Install `chef-handler-elapsed-time` gem during the compile phase
    chef_gem "chef-handler-elapsed-time"

    # load the gem here so it gets added to the $LOAD_PATH, otherwise chef_handler
    # will fail.
    require 'chef/handler/elapsed_time'

    # Activate the handler immediately during compile phase
    chef_handler "Chef::Handler::ElapsedTime" do
      source "chef/handler/elapsed_time"
      action :nothing
    end.run_action(:enable)

### Example output

    $ chef-client
    ...
    ...
    [2012-10-25T18:48:04+00:00] INFO: Running report handlers
    [2012-10-25T18:48:04+00:00] INFO: Resource                                            Elapsed Time(0.08s per unit)
    [2012-10-25T18:48:04+00:00] INFO: ========                                            ============
    [2012-10-25T18:48:04+00:00] INFO: remote_directory[/srv/chef/handlers]
    [2012-10-25T18:48:04+00:00] INFO: cookbook_file[/srv/chef/handlers/chef_profiler.rb]  ++++++++++++++++++++++++++++++
    [2012-10-25T18:48:04+00:00] INFO: chef_handler[Chef::Handler::Profiler]               +
    [2012-10-25T18:48:04+00:00] INFO: package[ntp]                                        ------
    [2012-10-25T18:48:04+00:00] INFO: package[ntpdate]                                    ------
    [2012-10-25T18:48:04+00:00] INFO: directory[/var/lib/ntp]
    [2012-10-25T18:48:04+00:00] INFO: directory[/var/log/ntpstats/]
    [2012-10-25T18:48:04+00:00] INFO: service[ntp]                                        ---------
    [2012-10-25T18:48:04+00:00] INFO: template[/etc/ntp.conf]                             -
    [2012-10-25T18:48:04+00:00] INFO: execute[apt-get-update]
    [2012-10-25T18:48:04+00:00] INFO: execute[apt-get update]
    [2012-10-25T18:48:04+00:00] INFO: package[update-notifier-common]                     ------
    [2012-10-25T18:48:04+00:00] INFO: execute[apt-get-update-periodic]
    [2012-10-25T18:48:04+00:00] INFO: directory[/var/cache/local]
    [2012-10-25T18:48:04+00:00] INFO: directory[/var/cache/local/preseeding]
    [2012-10-25T18:48:04+00:00] INFO: Report handlers complete

Licence
=======

Author: James Casey <jamesc.000@gmail.com>

Copyright 2011-2012 Opscode, Inc. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.
