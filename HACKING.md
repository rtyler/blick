# Hacking on Blick

Blick relies on the [Gradle](http://gradle.org) build tool by way of the
[jruby-gradle-jar-plugin](https://github.com/jruby-gradle/jruby-gradle-jar-plugin).

## Building

In order to build an agent jar, you only need to run `./gradlew shadowJar` in
the `blick/` directory.

## Testing

Running the [RSpec](http://rspec.org) tests requires executing: `./gradlew
spec`

## Running

The created "shadow jar" is fully self-contained and executable, executing it
requires building the jar (see above) and then: `java -jar
build/libs/blick-agent-all.jar`

**NOTE:** if you're using [rvm](http://rvm.io) or any other tool that sets the
`GEM_HOME` and/or `GEM_PATH` environment variables, you should unset them
before running the jar.
