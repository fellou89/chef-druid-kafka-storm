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
	

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request


License and Authors
-------------------
Copyright 2014 N3TWORK, Inc.<br>
Licensed under Apache 2.0<br>
Written by Yuval Oren (yuval@n3twork.com)
