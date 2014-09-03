# Disable Rake-environment-task framework detection by uncommenting/setting to false
Warbler.framework_detection = false

# Warbler web application assembly configuration file
Warbler::Config.new do |config|
  # Application directories to be included in the webapp.
  config.dirs = %w(bin lib config)

  # Additional files/directories to include, above those in config.dirs
  config.includes = FileList["tasks/pry.rake"]

  # Include gem dependencies not mentioned specifically. Default is
  # true, uncomment to turn off.
  config.gem_dependencies = false

  # Name of the archive (without the extension). Defaults to the basename
  # of the project directory.
  config.jar_name = ENV['JAR_NAME'] || 'blick.jar'

  # When set it specify the bytecode version for compiled class files
  config.bytecode_version = '1.7'

  # When set to true, Warbler will override the value of ENV['GEM_HOME'] even it
  # has already been set. When set to false it will use any existing value of
  # GEM_HOME if it is set.
  config.override_gem_home = false

  # Allows for specifing custom executables 
  #config.executable = ['rake']

  # Sets default (prefixed) parameters for the executables
  # config.executable_params = "do:something"

  # If set to true, moves jar files into WEB-INF/lib. Prior to version 1.4.2 of Warbler this was done
  # by default. But since 1.4.2 this config defaults to false. It may need to be set to true for
  # web servers that do not explode the WAR file.
  # config.move_jars_to_webinf_lib = false
end
