begin
  gem('rake-compiler')
  require 'rake/extensiontask'
  require 'rake/javaextensiontask'

  # Hack to avoid "allocator undefined for Proc" issue when unpacking Gems:
  # gemspec provided by Jeweler uses Rake::FileList for files, test_files and
  # extra_rdoc_files, and procs cannot be marshalled.
  def gemspec
    @clean_gemspec ||= eval("#{Rake.application.jeweler.gemspec.to_ruby}") # $SAFE = 3\n
  end

  Rake::ExtensionTask.new('do_oracle_ext', gemspec) do |ext|

    oracle_lib = File.expand_path(File.join(File.dirname(__FILE__), '..', 'vendor', 'oracle'))

    # automatically add build options to avoid need of manual input
    if RUBY_PLATFORM =~ /mswin|mingw/ then
    else
      ext.cross_compile = true
      ext.cross_platform = ['x86-mingw32', 'x86-mswin32-60']
    end

  end

  Rake::JavaExtensionTask.new('do_oracle_ext', gemspec) do |ext|
    ext.ext_dir   = 'ext-java/src/main/java'
    ext.classpath = '../do_jdbc/lib/do_jdbc_internal.jar'
    ext.java_compiling do |gem|
      gem.add_dependency "do_jdbc", '0.10.1'
      gem.post_install_message = <<EOF
==========================================================================

  DataObjects Oracle Driver:
    You've installed the binary extension for JRuby (Java platform)

==========================================================================
EOF
      #gem.files = Dir['lib/**/*.rb', 'spec/**/*.rb', 'tasks/**/*.rake',
      #              'LICENSE', 'Rakefile', '*.{markdown,rdoc,txt,yml}', 'lib/*.jar']
    end
  end
rescue LoadError
  warn "To compile, install rake-compiler (gem install rake-compiler)"
end
