begin
  gem('rake-compiler')
  require 'rake/javaextensiontask'

  # Hack to avoid "allocator undefined for Proc" issue when unpacking Gems:
  # gemspec provided by Jeweler uses Rake::FileList for files, test_files and
  # extra_rdoc_files, and procs cannot be marshalled.
  def gemspec
    @clean_gemspec ||= eval("#{Rake.application.jeweler.gemspec.to_ruby}") # $SAFE = 3\n
  end

  Rake::JavaExtensionTask.new('do_jdbc_internal', gemspec) do |ext|
    ext.ext_dir = 'src/main/java'
    ext.java_compiling do |gem_spec|
      gem_spec.post_install_message = <<EOF
==========================================================================

  DataObjects JDBC Support Library:
    You've installed the JDBC Support Library for JRuby (Java platform)

==========================================================================
EOF
    end
  end
rescue LoadError
  warn "To compile, install rake-compiler (gem install rake-compiler)"
end
