# Ansible from Cloudformation 

Can create an autoscaling group from any Ansible tarball.

## Design Decisions

### Ansible Kick-Off for CloudFormation

Currently we're using a home grown ruby script to kick off cloudformation 
templates, but we haven't made it flexible enough to drive all stack creation 
actions; instead, we've duplicated and adjusted the script.

By putting ansible in that role instead, we set ourselves up to maintain 
environmental differences between environments in ansible inventory files where 
they can be applied to multiple stacks.  It also allows us to keep building 
ansible glue between stacks that can, for example, consult the output of one 
stack before creating the next.  

This should lead to faster adoption of practices that can cut down on 
duplication and make creating new stacks as simple as building a group of 
ansible variables.

It also starts us in the right direction to use ansible on the orchestration 
layer.

### Less Mappings 

We've currently been using mappings to define the relationship between regions, 
availability zones, subnets, and instance types, but I believe this information 
is better collected to a central location that is consulted when the stack is 
created and passed as a parameter.  That lets us cut down significantly on 
duplication between the templates and keeps them simple, while also empowering 
us to change them as necessary  with global impact.   

### Expanded use of CFN Init Functions

By using metadta only for CFN-Init bootstrapping, we are effectively 
modularizing the other setup tasks on a system.  That means we could, for 
example, run both chef and ansible by specifying both CFN-Init configsets.  

## Parameters
### 
Tarball requirements:
* Must specify an inventory/ folder.  Dynamic information is created within.


