
require 'rubygems'
require 'rake'
require 'jeweler'
require 'rake/testtask'
require 'rcov/rcovtask'

NAME = "ms-fasta"
WEBSITE_BASE = "website"
WEBSITE_OUTPUT = WEBSITE_BASE + "/output"

gemspec = Gem::Specification.new do |s|
  s.name = NAME
  s.authors = ["John T. Prince"]
  s.email = "jtprince@gmail.com"
  s.homepage = "http://jtprince.github.com/" + NAME
  s.summary = "An mspire library for working with fasta formatted files"
  s.description = "provides programmatic access to fasta files"
  s.rubyforge_project = 'mspire'
  s.add_dependency("external", ">= 0.3.1")
  s.add_development_dependency("spec-more", ">= 1.1.0")
end

Jeweler::Tasks.new(gemspec)

Rake::TestTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end

Rcov::RcovTask.new do |spec|
  spec.libs << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.verbose = true
end


def rdoc_redirect(base_rdoc_output_dir, package_website_page, version)
  content = %Q{
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html><head><title>mspire: } + NAME + %Q{rdoc</title>
<meta http-equiv="REFRESH" content="0;url=#{package_website_page}/rdoc/#{version}/">
</head> </html> 
  }
  FileUtils.mkpath(base_rdoc_output_dir)
  File.open("#{base_rdoc_output_dir}/index.html", 'w') {|out| out.print content }
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  base_rdoc_output_dir = WEBSITE_OUTPUT + '/rdoc'
  version = File.read('VERSION')
  rdoc.rdoc_dir = base_rdoc_output_dir + "/#{version}"
  rdoc.title = NAME + ' ' + version
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :create_redirect do
  base_rdoc_output_dir = WEBSITE_OUTPUT + '/rdoc'
  rdoc_redirect(base_rdoc_output_dir, gemspec.homepage,version)
end

task :rdoc => :create_redirect

namespace :website do
  desc "checkout and configure the gh-pages submodule"
  task :init do
    if File.exist?(WEBSITE_OUTPUT + "/.git")
      puts "!! not doing anything, #{WEBSITE_OUTPUT + "/.git"} already exists !!"
    else

      puts "(not sure why this won't work programmatically)"
      puts "################################################"
      puts "[Execute these commands]"
      puts "################################################"
      puts "git submodule init"
      puts "git submodule update"
      puts "pushd #{WEBSITE_OUTPUT}"
      puts "git co --track -b gh-pages origin/gh-pages ;"
      puts "popd"
      puts "################################################"

      # not sure why this won't work!
      #%x{git submodule init}
      #%x{git submodule update}
      #Dir.chdir(WEBSITE_OUTPUT) do
      #  %x{git co --track -b gh-pages origin/gh-pages ;}
      #end
    end
  end
end

task :default => :spec

task :build => :gemspec

# credit: Rakefile modeled after Jeweler's
