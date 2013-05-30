require 'bundler/setup'

$:.push File.expand_path("../lib", __FILE__)
require "jgeoip/version"

# add maven repositories
repositories.remote << 'http://www.ibiblio.org/maven2'
repositories.remote << 'http://repo1.maven.org/maven2'

define 'jgeoip' do
  project.version = JGeoIP::VERSION
  
  # add dependencies from jar
  compile.using(:target => '1.6', :source => '1.6').with('org.kohsuke:geoip:jar:1.2.8')
  
  # package our shiny little bidder jar
  package :jar, :file => _("lib/java/jgeoip-#{JGeoIP::VERSION}.jar")
  
  desc 'copy all dependent jars to lib folder'
  task :copy_dependencies do
    cp project.compile.dependencies.collect(&:to_s), project.path_to('lib/java') 
  end
  
  task :setup => [ :clean, :compile, :package, :copy_dependencies ]
end
