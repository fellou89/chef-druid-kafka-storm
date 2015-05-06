# druid-example cookbook

This cookbook builds a single-node [Druid](http://druid.io/) cluster with the *wikipedia* example dataset. It is meant to be an example of how to use the [druid](https://github.com/N3TWORK/chef-druid) cookbook to build a full cluster. 

Requirements
------------
This cookbook is for Debian-based linux systems. It has been tested with Ubuntu using Vagrant as well as Amazon's AWS OpsWorks. Services are managed via *upstart*. 

It also depends on these cookbooks:

  * apt
  * database
  * [druid](https://github.com/N3TWORK/chef-druid)
  * mysql
  * zookeeper

Attributes
----------
None needed. See the [default recipe](recipes/default.rb) for attributes being set on the above cookbooks.

Usage
-----

### 1. Run the druid-example::default recipe

#### Using Vagrant
To set up a virtual machine using Vagrant, get [Vagrant](http://vagrantup.com) and the [Chef Development Kit](http://www.getchef.com/downloads/chef-dk). Then run:

    % vagrant up
    % vagrant ssh

#### Using something else
Include `druid-example` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[druid-example::default]"
  ]
}
```


### 2. Run the example client
From the machine:

	% cd /opt/druid/current
	% ./run_example_client.sh wikipedia
	


###Scripts that document things:

tmux-start-druid.sh - starts druid; designed to work inside tmux.
start-kafka-things.sh - starts kafka; probably only the "consumer" piece is need when run using storm because storm itself starts zookeeper and Kafka.

### Other projects that we use for this:

cloudspace/kafka-storm-tranquility
cloudspace/chef-druid-kafka
cloudspace/chef-druid-kafka-storm
cloudspace/storm-cookbook

Eventually chef-druid-kafka will probably be deprecated, but it may still have things that are useful.

Note, also, that currently, the use of the chef-druid-kafka-storm cookbook comes from a forked druid cookbook *which is broken*.  Part of that brokenness remains.  There are four upstart tasks under /etc/init/druid-* that need to be turned off (using ```stop TASKNAME```) for this to behave properly.
