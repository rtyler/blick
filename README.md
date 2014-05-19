# Blick

Blick is currently a concept, purely an experimental approach to a monitoring
system. While conceptually similar to [Sensu](https://github.com/sensu/sensu),
the idea behind Blick is to use [ZeroMQ](http://zeromq.org) to create
event-driven agents which stream events directly to a server.


## Contributing

The project is still in its infancy, but you can chat with us in the `#blick`
channel on the [Freenode](http://freenode.net) IRC network.


## Design

```
                              +--------> +--------------+       +--------------+
+---------------+             |          | Blick Server |       | Carbon Cache |
|  Blick Agent  |             |          +--------------+       +--------------+
+---------------+---> +-------+-----+        ^     ^                     ^
                      | Blick Relay |        |     |                     |
+---------------+---> +-------------+        |     +---+--------------+--+
|  Blick Agent  |                            |         | Blick Statsd |
+---------------+                            |         +--------------+
                                             |                   ^
                                   +---------+-----+             |
                                   |  Blick Agent  |       +-----+-------+
                                   +---------------+       | Application |
                                                           +-------------+

```

### Server


The Server is the main destionation for all Blick events. The Server is
responsible for aggregating event data, presenting data, and issuing alerts
based on that data.

The server should also receive some node information from Agents which can be
used to pull a node classification from a Puppet master or Chef server.
Ideally, the Server would be able to present automatic checks and alerts based
on what is presented in the node's classification. For example, if a `service {
'httpd': ensure => running, }` is defined in the node's [Puppet] resource graph
then the Server should automatically alert if the `httpd` process is not
running.

### Agent

The Agent's sole responsibility is to publish events via a ZeroMQ socket to the
Server, or a Relay.

The Agent should be primarily event driven, allowing multiple sources of
events, e.g.:

 * *System-level*: Provided by `dbus` or Kernel uevents (TBD)
 * *Process-level*: Provided by `systemd` to `dbus`

For non-evented data (`/proc` related events, non-standard process events) a
polling loop should exist in the Agent, but this should not be the default
mechanism for event acquisition.

It's currently unclear where application/process-level data, such as JMX,  should be
gathered from. This might make sense to live in the Agent, or the Relay.

#### Agent Design

```
                      +--------+                                                              
                      | ZeroMQ |                                                              
                      +--------+                                                              
                       ^                                                                      
                       |                                                                      
                       |                                                                      
+---------+     +------+----+           +-----------------+                                   
|Main loop|     | Publisher |<----------+ Process Monitor |                                   
+---------+     +-----------+           |   (listener)    |<--------- systemd/dbus            
                     ^ ^ ^ ^            +-----------------+                                   
                     | | | |                                                                  
                     | | | |           +--------------------+                                 
                     | | | +-----------+ Filesystem Monitor |<------- inotify/kqueue          
                     | | |             |    (listener)      |                                 
    +------------+   | | |             +--------------------+                                 
    | Heartbeat  +---+ | |                                                                    
    | (observer) |     | |                +---------------+                                   
    +------------+     | |                | MySQL Slow    |                                   
                       | +----------------+ Query Monitor |<--------- inotify/kqueue file-read
  +--------------+     |                  |  (listener)   |                                   
  | Disk Monitor +-----+                  +---------------+                                   
  |  (observer)  |                                                                            
  +--------------+                                                                            
```

##### Listeners

Listeners are evented entities within the agent, in order for a monitor to act
as a listener it must receive events from some external source on the system
being monitored.

Unless otherwise required, all monitors should be listeners by default.

##### Observers

Observers are all polling/interval based monitors that the agent will run in a
separate thread.


### Statsd

The intended purpose of the Statsd daemon is to provide application-based
monitoring and alerting. Blick should not replace Graphite but by using the
Blick Statsd server as the destination of Graphite events, Blick can get a
side-channel of these events and provide alerts based on their values.

### Relay

The Relay is more of a planned addition to help Blick scale. The Relay sitting
at the top of a rack, siphoning events from Agents as well as SNMP providers
into the Server would provide a more scalable means of data aggregation.
