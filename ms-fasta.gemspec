Gem::Specification.new do |s|
  s.name = "ms-fasta"
  s.version = "0.2.4"
  s.authors = ["Simon Chiang", "John Prince"]
  s.email = "simon.a.chiang@gmail.com"
  s.homepage = "http://mspire.rubyforge.org/projects/ms-fasta"
  s.platform = Gem::Platform::RUBY
  s.summary = "ms-fasta"
  s.require_path = "lib"
  s.rubyforge_project = "mspire"
  s.add_dependency("tap", ">= 0.17.1")
  s.add_development_dependency("tap-test", ">= 0.1.0")
  s.add_dependency("external", ">= 0.3.0")
  s.has_rdoc = true
  s.rdoc_options.concat %W{--main README.rdoc -S -N --title Ms-Fasta}
  
  # list extra rdoc files here.
  s.extra_rdoc_files = %W{
    History
    README.rdoc
    MIT-LICENSE
  }
  
  # list the files you want to include here. you can
  # check this manifest using 'rap print_manifest'
  s.files = %W{
    lib/ms/fasta.rb
    lib/ms/fasta/archive.rb
    lib/ms/fasta/entry.rb
    lib/ms/load/fasta.rb
    lib/ms/random/fasta.rb
    lib/ms/select/fasta.rb
    lib/ms/fasta/ipi.rb
    lib/ms/fasta/ipi/dat.rb
    tap.yml
  }
end
