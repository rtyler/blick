#!/usr/bin/env bash


function load_rvm() {
  source ~/.rvm/scripts/rvm
}

function use_jruby() {
  export JRUBY=${JRUBY:=jruby}
  export GEMSET=${GEMSET:=rubygems}

  echo ">> Using ${JRUBY} in ${GEMSET}"

  rvm use ${JRUBY}@${GEMSET}
}

function install_gems() {
  # Test to make sure we have bundler around
  gem which bundler > /dev/null

  if [ $? -ne 0 ]; then
    echo ">> Installing bundler into the ${GEMSET} gemset"
    gem install bundler --no-ri --no-rdoc
  fi;

  echo ">> Executing \`bundle install\`"
  bundle install
}
