# Blick notes

## Server


 * Should be able to act as a relay to an upstream server
 * 

## Client

 * Should discover server via multicast and/or some pluggable discovery
   mechanism, one of those "plugs" could just be a configuration file.
 * Should be able to take a catalog from Puppet for "my node" and pre-generate
   some process checks.
   * Every Service[foo] with `ensure => running` should be have a process check
     automatically added


## Checks

 * should be written in a modular fashion
 * should be installed on the machine, but also pulled down from the server if
   necessary. similar to puppet's plugin sync




## Listeners

Will listen for events via some callback/loop mechanism

## Observers

Will observe events via polls


